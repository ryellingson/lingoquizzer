class RemoveAnswerFromProblems < ActiveRecord::Migration[6.0]
  def change
    remove_column :problems, :answer, :string
  end
end
