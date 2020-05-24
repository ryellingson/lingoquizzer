class AddHelpTipToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :help_tip, :text
  end
end
