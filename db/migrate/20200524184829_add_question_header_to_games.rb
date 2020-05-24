class AddQuestionHeaderToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :question_header, :string
  end
end
