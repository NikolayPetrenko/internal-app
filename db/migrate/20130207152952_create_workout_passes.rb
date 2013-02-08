class CreateWorkoutPasses < ActiveRecord::Migration
  def change
    create_table :workout_passes do |t|
      t.references :assigned_by
      t.references :owner
      t.references :assigned_to
      t.references :workout
      t.integer :total_time
      t.date :start_time
      t.date :end_time

      t.timestamps
    end
    add_index :workout_passes, :assigned_by_id
    add_index :workout_passes, :owner_id
    add_index :workout_passes, :assigned_to_id
    add_index :workout_passes, :workout_id
  end
end
