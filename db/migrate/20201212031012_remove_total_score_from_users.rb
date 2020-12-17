class RemoveTotalScoreFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :total_score
  end
end
