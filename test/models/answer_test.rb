require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  def setup
    @answer = Answer.new(content: "Answer", question_id: 1, user_id: 1)
  end

end
