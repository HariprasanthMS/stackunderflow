class TopicsController < ApplicationController
  def index
    @topics = Topic.paginate(page: params[:page])
    @answer = Answer.new
  end

  def show
    @topic = Topic.find(params[:id])
    @questions = @topic.questions.paginate(page: params[:page])
    @answer = Answer.new
  end
end
