require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'test' do
    expect(create(:task)).to be_a Task
  end
end
