class Group < ActiveRecord::Base
  belongs_to :user

  has_and_belongs_to_many :users

  attr_accessible :title

  def users_count
    users.count
  end
end
