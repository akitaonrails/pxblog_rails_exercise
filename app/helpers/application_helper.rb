module ApplicationHelper
  def current_user
    session[:current_user]
  end
end
