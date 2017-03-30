class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.string :team
      t.integer :score
      t.belongs_to :board, index: true
      t.timestamps
    end
  end
end
