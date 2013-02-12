class HighScore < ActiveRecord::Base
  attr_accessible :user_id, :score
  validates :user_id, presence: true
  validates :score, presence: true
  
  belongs_to :user
end
