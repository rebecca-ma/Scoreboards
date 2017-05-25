class CreateMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :missions do |t|
      t.text :description
      t.string :title
      t.string :giver
      t.timestamps
    end
  end
end
