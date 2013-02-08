class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.string :body
      t.integer :is_valid

      t.timestamps
    end
    add_index :answers, :question_id
  end
end
