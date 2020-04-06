class AddReferenceToProblems < ActiveRecord::Migration[6.0]
  def change
    remove_column :problems, :game_id
    add_reference :problems, :game, null: false, foreign_key: true
  end
end
