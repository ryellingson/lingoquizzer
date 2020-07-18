class AddMarkdownContentToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :markdown_content, :text
  end
end
