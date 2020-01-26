require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  let(:task_new) { create(:task) }
  let(:task_last) { Task.last }
  before :each do
    visit root_path
  end

  describe 'Basic task feature flow', js: true do
    scenario 'When create task' do
      click_link '新增任務'
      within('form') do
        fill_in_task_form
      end
      click_button 'Create Task'
      expect_task_form(task_last)
      expect(page).to have_content('新增成功')
      expect(Task.count).to eq 1
    end

    scenario 'When read the task' do
      click_link '查看'
      expect_task_form(task_last)
    end

    scenario 'When edit task' do
      click_link '編輯'
      within('form') do
        select '進行中', from: 'task_status'
      end
      click_button 'Update Task'
      expect(page).to have_content('編輯成功')
      expect(task_last.status).to eq 'processing'
      expect(Task.count).to eq 1
    end

    scenario 'When delete task', js: true do
      click_link '刪除'
      expect(page.driver.browser.switch_to.alert.text).to eq '確定刪除？'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content('刪除成功')
      expect(task_last).to be nil
      expect(Task.count).to eq 0
    end
  end

  def fill_in_task_form
    fill_in 'task_title', with: 'Coding'
    fill_in 'task_content', with: 'This is RSpec test'
    fill_in 'task_start_at', with: 'Sat, 25 Jan 2020 23:14:50 +0800'
    fill_in 'task_end_at', with: 'Thu, 30 Jan 2020 23:15:17 +0800 '
    select '待處理', from: 'task_status'
    choose 'task_priority_high'
  end

  def expect_task_form(task)
    expect(task.title).to eq 'Coding'
    expect(task.content).to eq 'This is RSpec test'
    expect(task.start_at).to eq 'Sat, 25 Jan 2020 23:14:50 +0800'
    expect(task.end_at).to eq 'Thu, 30 Jan 2020 23:15:17 +0800'
    expect(task.status).to eq 'pending'
    expect(task.priority).to eq 'high'
  end
end
