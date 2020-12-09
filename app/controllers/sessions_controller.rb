class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(session_params.except(:password))
    if user&.authenticate(session_params[:password])
      log_in(user)
      remember(user)
      flash[:success] = "#{user.name} successfully logged in"
      redirect_to user
    else
      flash.now[:danger] = "Incorrect username or password"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:name, :email, :password)
  end
end
