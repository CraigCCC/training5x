require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task_new) { create(:task) }
  before { task_new }

  describe 'Validations' do
    it 'Column must be presence(title, start_at, end_at, priority, status)' do
      should validate_presence_of(:title)
      should validate_presence_of(:start_at)
      should validate_presence_of(:end_at)
      should validate_presence_of(:priority)
      should validate_presence_of(:status)
    end

    it 'Column must be limit length' do
      should validate_length_of(:title).is_at_most(50)
    end

    it 'If end_at greater than start_at, should be alert 不可晚於開始日期' do
      task_new.end_at -= 6.days
      task_new.valid?
      expect(task_new.errors.messages[:end_at]).to include('不可晚於開始日期')
    end

    it 'If column is nil, should be alert: 不可為空白' do
      task_new.title = nil
      task_new.start_at = nil
      task_new.end_at = nil
      task_new.valid?
      expect(task_new.errors.messages[:title]).to include('不可為空白')
      expect(task_new.errors.messages[:start_at]).to include('不可為空白')
      expect(task_new.errors.messages[:end_at]).to include('不可為空白')
    end
  end
end
