class AddLanguageCodeToLanguages < ActiveRecord::Migration[6.0]
  def change
    add_column :languages, :language_code, :string
  end
end
