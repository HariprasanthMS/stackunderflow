class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the anti-chaos club"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def destroy
    log_out
    reset_session
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email,
                                   :password, :password_confirmation)
    end
end