require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  let(:new_task) { create(:task) }
  let(:last_task) { Task.last }
  before :each do
    visit root_path
  end

  describe 'Basic task feature flow', js: true do
    scenario 'When create task' do
      click_link '新增任務'
      within('form') do
        fill_in 'task_title', with: 'Coding'
        fill_in 'task_content', with: 'This is RSpec test'
        fill_in 'task_start_at', with: 'Sat, 25 Jan 2020 23:14:50 +0800'
        fill_in 'task_end_at', with: 'Thu, 30 Jan 2020 23:15:17 +0800 '
        select '待處理', from: 'task_status'
        choose 'task_priority_high'
      end
      click_button '送出'
      expect_task_info_equal(last_task)
      expect(page).to have_content('新增成功')
      expect(Task.count).to eq 1
    end

    scenario 'When read the task' do
      click_link '查看'
      expect_task_info_equal(last_task)
    end

    scenario 'When edit task' do
      click_link '編輯'
      within('form') do
        select '進行中', from: 'task_status'
      end
      click_button '送出'
      expect(page).to have_content('編輯成功')
      expect(last_task.status).to eq 'processing'
      expect(Task.count).to eq 1
    end

    scenario 'When delete task', js: true do
      click_link '刪除'
      expect(page.driver.browser.switch_to.alert.text).to eq '確定刪除？'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content('刪除成功')
      expect(last_task).to be nil
      expect(Task.count).to eq 0
    end
  end

  describe 'Sort task flow' do
    let(:first_task) { create(:task, created_at: '2020-01-31 11:00') }
    let(:second_task) { create(:task, created_at: '2020-02-01 11:00') }
    before do
      first_task
      second_task
      visit root_path
    end
    scenario 'Default sort by created_at', js: true do
      within 'tbody tr:nth-child(1)' do
        expect(page).to have_content(second_task.title)
      end
      within 'tbody tr:nth-child(2)' do
        expect(page).to have_content(first_task.title)
      end
    end
  end

  def expect_task_info_equal(task)
    expect(task.title).to eq 'Coding'
    expect(task.content).to eq 'This is RSpec test'
    expect(task.start_at).to eq 'Sat, 25 Jan 2020 23:14:50 +0800'
    expect(task.end_at).to eq 'Thu, 30 Jan 2020 23:15:17 +0800'
    expect(task.status).to eq 'pending'
    expect(task.priority).to eq 'high'
  end
end
