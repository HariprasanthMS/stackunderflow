class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :votes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence: true
end
