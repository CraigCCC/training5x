require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:new_task) { create(:task) }
  it { should define_enum_for(:status).with_values([:pending, :processing, :done]) }
  before { new_task }

  describe 'Validations' do
    it 'Task must has title, start_at, end_at, priority, status' do
      should validate_presence_of(:title)
      should validate_presence_of(:start_at)
      should validate_presence_of(:end_at)
      should validate_presence_of(:priority)
      should validate_presence_of(:status)
    end

    it 'When title is too long' do
      should validate_length_of(:title).is_at_most(50)
    end

    it 'When start_at greater than end_at' do
      new_task.end_at -= 6.days
      new_task.valid?
      expect(new_task.errors.messages[:end_at]).to include('不可早於開始日期')
    end

    it 'When column is nil' do
      new_task.title = nil
      new_task.start_at = nil
      new_task.end_at = nil
      new_task.valid?
      expect(new_task.errors.messages[:title]).to include('不可為空白')
      expect(new_task.errors.messages[:start_at]).to include('不可為空白')
      expect(new_task.errors.messages[:end_at]).to include('不可為空白')
    end
  end

  describe 'Search Tasks' do
    it 'When search by title' do
      target_task = FactoryBot.create(:task, :title)

      search_by_title_and_status(target_task, 'Hello World', '', '')
    end

    it 'When search by status' do
      pending_task = FactoryBot.create(:task)
      processing_task = FactoryBot.create(:task, :processing)
      done_task = FactoryBot.create(:task, :done)

      search_by_title_and_status(pending_task, '', 'pending', '0')
      search_by_title_and_status(processing_task, '', 'processing', '1')
      search_by_title_and_status(done_task, '', 'done', '2')
    end

    it 'When search by title and status' do
      target_task = FactoryBot.create(:task, :title, :done)
      search_by_title_and_status(target_task, 'Hello World', 'done', '2')
    end
  end

  private

  def search_by_title_and_status(target_task, title, status, enum)
    params = { search: title, search_status: enum }
    @tasks = Task.search_like(params[:search]).search_status(params[:search_status]).sort_by_created_at
    expect(@tasks.first).to eq(target_task)
    @tasks.each do |task|
      expect(task.title).to eq(title) if params[:search].present?
      expect(task.status).to eq(status) if params[:search_status].present?
    end
  end
end
