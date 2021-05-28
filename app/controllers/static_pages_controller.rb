class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @question  = current_user.questions.build
      @questions = current_user.questions.paginate(page: params[:page])
      @answer = current_user.answers.build
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
