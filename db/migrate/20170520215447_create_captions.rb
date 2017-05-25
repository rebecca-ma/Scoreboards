class CreateCaptions < ActiveRecord::Migration[5.0]
  def change
    create_table :captions do |t|
      t.belongs_to :photo, index: true
      t.text :text
      t.timestamps
    end
  end
end
