class Question < ActiveRecord::Base
  
  has_many :answers
  belongs_to :user

  validates :subject, :post, presence: true
  
end