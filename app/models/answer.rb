class Answer < ActiveRecord::Base
  belongs_to :question
  attr_accessible :body, :is_valid

  validates :body, :presence => true
end
