class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      if user.activated?
        log_in(user)
        if session_params[:remember_me] == "1"
          remember(user)
        else
          forget(user)
        end
        flash[:success] = "#{user.name} successfully logged in"
        redirect_back_or(user)
      else
        flash[:info] = "You must activate your account first. Please check your email for more information"
        redirect_to login_path
      end
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
    params.require(:session).permit(:email, :password, :remember_me)
  end
end
