class UserTopicRelationsController < ApplicationController
  before_action :logged_in_user

  def create
    @topic = Topic.find(params[:topic_id])
    current_user.follow(@topic)
    respond_to do |format|
      format.html { redirect_to @topic }
      format.js
    end
  end

  def destroy
    @topic = UserTopicRelation.find(params[:id]).topic
    current_user.unfollow(@topic)
    respond_to do |format|
      format.html { redirect_to @topic }
      format.js
    end
  end
end
