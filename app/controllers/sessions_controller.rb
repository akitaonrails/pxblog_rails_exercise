class SessionsController < ApplicationController
  # GET /sessions/new
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_username(session_params[:username])

    respond_to do |format|
      if @user && @user.authenticate(session_params[:password])
        session[:current_user] = {id: @user.id, username: @user.username}
        format.html { redirect_to posts_path, notice: 'Sign in successful!' }
      else
        format.html { redirect_to new_session_path, alert: 'Invalid username/password combination!' }
      end
    end
  end

  def destroy
    session[:current_user] = nil
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Signed out successfully!' }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.require(:user).permit(:username, :password)
  end
end