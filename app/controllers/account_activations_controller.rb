class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:activation_token])
      user.activated = true
      user.activated_at = Time.current
      user.save!(validate: false)
      flash[:success] = "Account #{user.name} successfully activated"
    else
      flash[:danger] = "Activation link is invalid"
    end
    redirect_to login_path
  end
end
