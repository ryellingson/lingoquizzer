class AddCountToPlays < ActiveRecord::Migration[6.0]
  def change
    add_column :plays, :count, :integer
  end
end
