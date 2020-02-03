require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:new_task) { create(:task) }
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

    it 'When end_at greater than start_at' do
      new_task.end_at -= 6.days
      new_task.valid?
      expect(new_task.errors.messages[:end_at]).to include('不可晚於開始日期')
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
end
