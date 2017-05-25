class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.text :caption
      t.belongs_to :user, index: true
      t.belongs_to :team, index: true
      t.boolean :admin_uploaded
      t.timestamps
    end
  end
end
