class AddPostToComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :parent_type, :string
    remove_column :comments, :parent_id, :bigint
    add_reference :comments, :post, index: true
  end
end
