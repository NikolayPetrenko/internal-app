class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :workout
      t.text :body
      t.string :answer_type
      t.boolean :random_answers

      t.timestamps
    end
    add_index :questions, :workout_id
  end
end
