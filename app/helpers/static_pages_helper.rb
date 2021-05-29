module StaticPagesHelper
  def getUserVotedQuestions
    voted_questions = current_user.votes.map do | vote |
      vote.answer.question
    end 
    voted_questions.uniq
  end

  def getFeed
    questions = current_user.questions.map do | question |
      question
    end
    current_user.topics.each do | topic |
      topic.questions.each do | question |
        questions << question
      end
    end
    questions.uniq
  end

  def getAnsweredQuestions
    answered_questions = current_user.answers.map do | answer |
      answer.question
    end
  end

  def getMyQuestions
    my_questions = current_user.questions.map do | question |
      question
    end
  end
end
