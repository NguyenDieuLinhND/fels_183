class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :avatar
      t.boolean :is_admin, default: false
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
