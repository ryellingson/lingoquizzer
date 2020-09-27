class AddNewPointsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :assist_points, :integer, default: 0
    add_column :users, :hint_points, :integer, default: 0
  end
end
