require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  let!(:task_first) { FactoryBot.create(:task) }
  before :each do
    visit root_path
  end

  describe '檢視任務index頁面' do
    scenario '期望顯示與新增數量一樣' do
      5.times { FactoryBot.create(:task) }
      visit root_path
      expect(Task.count).to eq 6
    end
  end

  describe '新增任務功能' do
    scenario '期望是成功的新增' do
      click_link '新增任務'
      within('form') do
        fill_in 'task_title', with: 'Coding'
        fill_in 'task_content', with: 'I love RSpec, I love TDD'
        fill_in 'task_start_at', with: Time.current
        fill_in 'task_end_at', with: Time.current + 5.days
        select '待處理', from: 'task_status'
        choose 'task_priority_high'
      end
      click_button 'Create Task'
      expect(page).to have_content('新增成功')
      expect(page).to have_content('Coding')
      expect(page).to have_content(Time.current)
      expect(page).to have_content(Time.current + 5.days)
      expect(page).to have_content('pending')
      expect(page).to have_content('high')
      expect(Task.count).to eq 2
    end
  end

  describe '編輯任務功能' do
    scenario '期望是成功的編輯' do
      click_link '編輯'
      within('form') do
        fill_in 'task_title', with: 'Do something'
        fill_in 'task_content', with: 'Happy hacking !!'
        select '進行中', from: 'task_status'
        choose 'task_priority_low'
      end
      click_button 'Update Task'
      expect(page).to have_content('編輯成功')
      expect(page).to have_content('Do something')
      expect(page).to have_content('processing')
      expect(page).to have_content('low')
      expect(Task.count).to eq 1
    end
  end

  describe '刪除任務功能' do
    scenario '期望是成功的刪除' do
      click_link '刪除'
      expect(page).to have_content('刪除成功')
      expect(page).not_to have_content(task_first.title)
      expect(Task.count).to eq 0
    end
  end

  describe '查看任務功能' do
    scenario '期望是成功的查看' do
      click_link '查看'
      expect(page).to have_content(task_first.title)
      expect(page).to have_content(task_first.content)
      expect(page).to have_content(task_first.status)
      expect(page).to have_content(task_first.priority)
      expect(page).to have_content(task_first.start_at)
      expect(page).to have_content(task_first.end_at)
    end
  end
end
