class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :index, :destroy, :questions, :answered_questions, :voted_questions]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @question  = current_user.questions.build
    @questions = current_user.questions.paginate(page: params[:page])
    @other_user_questions = @user.questions.paginate(page: params[:page])
    @profile_user = @user
    @answer = current_user.answers.build
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the anti-chaos club"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def questions
    @user = User.find(params[:id])
    @answer = current_user.answers.build
    if current_user?(@user)
      title = "Your"
      empty_text = "You"
    else
      title = @user.name + "'s"
      empty_text = @user.name
    end

    title += " #{"question".pluralize(@user.questions.count)}"
    @user_questions = get_user_questions
    empty_text += " haven't asked any questions"

    count = @user.questions.count
    render 'shared/user_questions', locals: { questions: @user_questions, empty_text: empty_text, title: title, count: count }
  end

  def answered_questions
    @user = User.find(params[:id])
    @answer = current_user.answers.build
    if current_user?(@user)
      title = "you"
      empty_text = "You"
    else
      title = @user.name
      empty_text = @user.name
    end

    title = "#{"Answer".pluralize(@user.answers.count)} #{title} provided"
    @user_questions = get_user_answered_questions
    empty_text += " haven't answered any questions"

    count = @user.answers.count
    render 'shared/user_questions', locals: { questions: @user_questions, empty_text: empty_text, title: title, count: count }
  end

  def voted_questions
    @user = User.find(params[:id])
    @answer = current_user.answers.build
    if current_user?(@user)
      title = "Your"
      empty_text = "You"
    else
      title = @user.name
      empty_text = @user.name
    end

    title += " voted #{"answer".pluralize(@user.votes.count)}"
    @user_questions = get_user_voted_questions
    empty_text += " haven't voted any answers"
    count = @user.votes.count
    render 'shared/user_questions', locals: { questions: @user_questions, empty_text: empty_text, title: title, count: count }
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # def destroy
  #   log_out
  #   reset_session
  # end
  
  private

    def user_params
      params.require(:user).permit(:name, :email,
                                   :password, :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def get_user_voted_questions
      voted_questions = User.find(params[:id]).votes.map do | vote |
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
  
    def get_user_answered_questions
      answered_questions = User.find(params[:id]).answers.map do | answer |
        answer.question
      end
    end
  
    def get_user_questions
      my_questions = User.find(params[:id]).questions.map do | question |
        question
      end
    end
end
