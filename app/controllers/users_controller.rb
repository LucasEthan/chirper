class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update index]
  before_action :correct_user, only: %i[edit update]
  before_action :only_admin, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account #{@user.name} successfully created"
      flash[:info] = "Please check your email to activate your account"
      @user.send_activation_email
      redirect_to login_path
    else
      flash.now[:danger] = helpers.form_error_message(@user)
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @chirps = @user.chirps.all.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Account #{@user.name} successfully updated"
      redirect_to @user
    else
      flash.now[:danger] = helpers.form_error_message(@user)
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Account #{@user.name} successfully deleted"
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = "Unauthorized action"
      redirect_to @user
    end
  end

  def only_admin
    redirect_to root_path unless current_user.admin?
  end
end
