require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "shows the login form" do
    get :new
    assert_response :success
  end

  test "creates a new user session for a valid user" do
    post :create, user: {username: @user.username, password: "password"}
    assert session[:current_user]
    assert flash[:notice] == "Sign in successful!"
    assert_redirected_to posts_path
  end

  test "does not create a session with a bad login" do
    post :create, user: {username: @user.username, password: "wrong"}
    refute session[:current_user]
    assert flash[:alert] == "Invalid username/password combination!"
    assert_redirected_to new_session_path
  end

  test "does not create a session if user does not exist" do
    post :create, user: {username: "foo", password: "wrong"}
    assert flash[:alert] == "Invalid username/password combination!"
    assert_redirected_to new_session_path
  end

  test "deletes the user session if it exists" do
    session[:current_user] = {id: @user.id}
    delete :destroy
    refute session[:current_user]
    assert flash[:notice] == "Signed out successfully!"
    assert_redirected_to posts_path
  end
end