class AddTypeToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :character_type, :integer
  end
end
