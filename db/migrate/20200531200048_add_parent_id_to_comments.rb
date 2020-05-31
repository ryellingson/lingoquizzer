class AddParentIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :parent, null: false, polymorphic: true
  end
end
