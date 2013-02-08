class WorkoutPass < ActiveRecord::Base
  belongs_to :assigned_by, :class_name => "User"
  # belongs_to :owner, :class_name => "User"
  belongs_to :assigned_to, :class_name => "User"
  belongs_to :workout
  attr_accessible :end_time, :start_time, :total_time
end
