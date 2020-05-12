class AddIconBasedToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :icon_based, :boolean, default: false
  end
end
