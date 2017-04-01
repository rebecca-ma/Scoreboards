class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :encrypted_password
      t.string :salt
      t.timestamps
    end
  end
end
