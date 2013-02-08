class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  
  attr_accessible :allow_question_skip, :title, :warn_empty_questions

  validates :title, :presence => true, :length => {:minimum => 2}
end
