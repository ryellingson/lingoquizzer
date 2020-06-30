class AddGameTypeToGames < ActiveRecord::Migration[6.0]
  def up
    add_column :games, :character_type, :integer
    add_column :games, :score, :integer
    add_column :games, :play_time, :integer
    add_column :games, :description, :text
    add_column :games, :category, :integer
    add_column :games, :difficulty, :integer
    add_column :games, :genre, :integer
    remove_reference :games, :category, foreign_key: true
    remove_reference :games, :difficulty, foreign_key: true
    remove_reference :games, :genre, foreign_key: true
    drop_table :categories
    drop_table :genres
    drop_table :difficulties
  end

  def down
    remove_column :games, :character_type
    remove_column :games, :score
    remove_column :games, :play_time
    remove_column :games, :description
    remove_column :games, :category
    remove_column :games, :difficulty
    remove_column :games, :genre
    create_table :categories do |t|
      t.string :name
    end
    create_table :genres do |t|
      t.string :name
    end
    create_table :difficulties do |t|
      t.string :level
    end
    add_reference :games, :category, foreign_key: true
    add_reference :games, :difficulty, foreign_key: true
    add_reference :games, :genre, foreign_key: true
  end
end
