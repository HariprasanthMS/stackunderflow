class StaticPagesController < ApplicationController
  include StaticPagesHelper

  before_action :logged_in_user, only: [:myAnswers]

  def home
    if logged_in?
      @question  = current_user.questions.build
      @questions = getFeed
      @answer = current_user.answers.build
    end
  end

  def my_answers
    @question  = current_user.questions.build
    @answer = current_user.answers.build
    @my_answered_questions = getAnsweredQuestions
  end

  def my_questions
    @question  = current_user.questions.build
    @answer = current_user.answers.build
    @my_questions = getMyQuestions
  end

  def search
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else
      @parameter = params[:search].downcase
      @answer = Answer.new
      @results = Question.where(Question.arel_table[:content].matches("%#{@parameter}%"))
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end
end
