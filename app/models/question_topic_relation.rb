class QuestionTopicRelation < ApplicationRecord
  belongs_to :question
  belongs_to :topic

  validates :question_id, presence: true
  validates :topic_id, presence: true
  
end
