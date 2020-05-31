class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name

      t.timestamps
    end
    add_reference :games, :language
    add_reference :messages, :language
    add_reference :posts, :language
  end
end
