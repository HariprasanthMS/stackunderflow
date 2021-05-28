class Question < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many :question_topic_relations, dependent: :destroy
  has_many :topics, through: :question_topic_relations
  has_many :answers, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true
end
