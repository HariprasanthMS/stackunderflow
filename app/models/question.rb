class Question < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many :question_topic_relations, dependent: :destroy
  has_many :topics, through: :question_topic_relations
  has_many :answers, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true

  # def self.match_scope_condition(col, query)
  #   arel_table[col].matches("%#{query}%")
  # end

  # scope :matching, lambda {|*args|
  #   col, opts = args.shift, args.extract_options!
  #   op = opts[:operator] || :or
  #   where args.flatten.map {|query| match_scope_condition(col, query) }.inject(&op)
  # }

  # scope :matching_content, lambda {|*query|
  #   matching(:content, *query)
  # }

end
