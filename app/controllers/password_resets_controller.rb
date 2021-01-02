class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: password_resets_params[:email])
    if @user
      @user.create_reset_digest
      @user.send_reset_email
    end
    flash[:info] = "Please check your email for the password reset instructions"
    redirect_to login_path
  end

  def edit
  end

  def update
  end

  private

  def password_resets_params
    params.require(:password_reset).permit(:email)
  end
end
