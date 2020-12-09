class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(session_params.except(:password, :remember_me))
    if user&.authenticate(session_params[:password])
      log_in(user)
      if session_params[:remember_me] == "1"
        remember(user)
      else
        forget(user)
      end
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
    params.require(:session).permit(:name, :email, :password, :remember_me)
  end
end
