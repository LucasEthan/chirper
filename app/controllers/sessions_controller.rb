class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
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
    log_out
    flash[:info] = "Successfully logged out"
    redirect_to root_path
  end
end
