module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    user.find_by(id: session[:user_id]) if session[:user_id]
  end
end
