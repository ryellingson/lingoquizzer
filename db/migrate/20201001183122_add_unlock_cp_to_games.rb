class AddUnlockCpToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :unlock_cp, :integer, default: 0
  end
end
