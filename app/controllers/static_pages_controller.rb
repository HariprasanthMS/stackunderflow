class StaticPagesController < ApplicationController
  include StaticPagesHelper

  before_action :logged_in_user, only: [:myAnswers]

  def home
    if logged_in?
      @question  = current_user.questions.build
      @questions = getFeed
      @answer = current_user.answers.build
      @profile_user = current_user
    end
  end

  def my_answers
    @answer = current_user.answers.build
    @my_answered_questions = getAnsweredQuestions
  end

  def my_questions
    @answer = current_user.answers.build
    @my_questions = getMyQuestions
    render 'shared/user_questions', locals: { questions: @my_questions }
  end

  def my_voted_questions
    @answer = current_user.answers.build
    @my_voted_questions = getUserVotedQuestions
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
