class AddAuthorsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :authors, :jsonb
  end
end
