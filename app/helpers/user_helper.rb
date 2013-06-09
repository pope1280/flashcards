helpers do

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_history
    if current_user.rounds.length > 0
      :_user_history
    end
  end

end
