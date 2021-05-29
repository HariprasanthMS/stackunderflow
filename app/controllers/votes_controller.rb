class VotesController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]

  def create
    @vote = Vote.find_by(user_id: params[:user_id], answer_id: params[:answer_id])
    if @vote.nil?
      @vote = current_user.votes.build(vote_params)
      if @vote.save
        flash[:success] = "Vote added!"
        redirect_back(fallback_location: root_url)
      else
        @question = @answer.question
        @questions = current_user.questions.paginate(page: params[:page])
        # render 'static_pages/home'
        flash[:danger] = @answer.errors.messages[:content]
        redirect_back(fallback_location: root_url)
      end
    else
      update
    end
  end

  def update
    @vote = current_user.votes.find_by(answer_id: params[:answer_id])
    if @vote.update(vote_params)
      flash[:success] = "Vote updated"
      redirect_back(fallback_location: root_url)
    else
      flash[:danger] = @vote.errors.messages[:content]
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy

  end

  private
    def vote_params
      params.permit(:answer_id, :vote_type)
    end

end
