class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :data
      t.references :problem, null: false, foreign_key: true

      t.timestamps
    end
  end
end
