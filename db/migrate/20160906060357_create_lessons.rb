class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.integer :category_id
      t.integer :user_id
      t.boolean :is_completed, default: false
      t.timestamps
    end
  end
end
