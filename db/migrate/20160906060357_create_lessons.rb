class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.integer :category_id
      t.integer :user_id
      t.integer :status, default: 0
      t.integer :spent_time, default: 0
      t.datetime :started_at
      t.integer :score, default: 0
      t.timestamps
    end
  end
end
