class AddDefaultAvatarToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :default_avatar, :string
  end
end
