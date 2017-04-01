class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :score
      t.belongs_to :team, index: true
      t.belongs_to :board, index: true
      t.timestamps
    end
  end
end
