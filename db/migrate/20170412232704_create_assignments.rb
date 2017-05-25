class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.belongs_to :team, index: true
      t.belongs_to :mission, index: true
      t.datetime :start_time
      t.datetime :completed_time
      t.timestamps
    end
  end
end
