class Topic < ApplicationRecord
  has_many :user_topic_relations, dependent: :destroy
  has_many :question_topic_relations, dependent: :destroy
  
  has_many :users, through: :user_topic_relations
  has_many :questions, through: :question_topic_relations
end
