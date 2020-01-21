class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.integer :status
      t.integer :priority
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
