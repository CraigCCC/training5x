class ChangeTaskTitleAndContentColumn < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :title, :string, limit: 50
  end
end
