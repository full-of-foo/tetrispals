class HighScore < ActiveRecord::Base
  attr_accessible :score
  validates :user_id, presence: true
  validates :score, presence: true
  
  belongs_to :user
end
