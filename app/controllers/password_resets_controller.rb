class PasswordResetsController < ApplicationController
  before_action :retrieve_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

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

  def retrieve_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user&.activated? && @user.authenticated?(:reset, params[:reset_token])
      flash[:danger] = "An error has occurred, please try again"
      redirect_to login_path
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:info] = "The password reset link has expired"
      redirect_to new_password_reset_path
    end
  end
end
