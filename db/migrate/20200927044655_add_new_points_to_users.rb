class AddNewPointsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :convo_points, :integer, default: 0
    add_column :users, :hint_points, :integer, default: 0
  end
end
