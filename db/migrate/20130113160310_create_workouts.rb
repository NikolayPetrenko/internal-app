class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :user
      t.string :title
      t.boolean :allow_question_skip
      t.boolean :warn_empty_questions

      t.timestamps
    end
    add_index :workouts, :user_id
  end
end
