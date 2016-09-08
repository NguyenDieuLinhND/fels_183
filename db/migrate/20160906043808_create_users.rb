class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :avatar, default: "http://www.aiche.org/sites/default/files/profile-photo-default/avatar.gif"
      t.boolean :is_admin, default: false
      t.timestamps
    end
  end
end
