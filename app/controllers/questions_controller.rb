class QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @questions = Question.all.paginate(page: params[:page])
    @answer = Answer.new
  end

  def create
    @question = current_user.questions.build(question_params)
    @topics = params[:question][:topic_names].split("\r\n")
    
    if @question.save
      @topics.each do |t|
        topic = Topic.find_by(name: t)
        if topic.nil?
          topic = Topic.create(name: t)
        end
        QuestionTopicRelation.create(topic_id: topic.id, question_id: @question.id)
      end
      flash[:success] = "Question posted!"
      redirect_back(fallback_location: root_url)
    else
      @user_questions = current_user.questions.paginate(page: params[:page])
      @answer = current_user.answers.build
      render 'static_pages/home'
    end
  end

  def show

  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted"
    redirect_back(fallback_location: root_url)
  end

  private

    def question_params
      params.require(:question).permit(:content)
    end

    # Confirms the correct user.
    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end
  
end
