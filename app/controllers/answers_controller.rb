class AnswersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      flash[:success] = "Answer posted!"
      redirect_to root_url
    else
      @questions = current_user.questions.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = "Answer deleted"
    redirect_back(fallback_location: root_url)
  end

  private

    def answer_params
      params.require(:answer).permit(:content)
    end

    # Confirms the correct user.
    def correct_user
      @answer = current_user.answers.find_by(id: params[:id])
      redirect_to root_url if @answer.nil?
    end
end
