class AddNewReferencesToGames < ActiveRecord::Migration[6.0]
  def change
    add_reference :games, :category, null: false, foreign_key: true
    add_reference :games, :genre, null: false, foreign_key: true
    add_reference :games, :difficulty, null: false, foreign_key: true
  end
end
