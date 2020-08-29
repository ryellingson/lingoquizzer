class AddVideoUrlToLanguages < ActiveRecord::Migration[6.0]
  def change
    add_column :languages, :video_url, :string
  end
end
