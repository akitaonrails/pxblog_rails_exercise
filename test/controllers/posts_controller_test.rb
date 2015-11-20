require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @user = users(:user_one)
    @post = @user.posts.first
    session[:current_user] = {id: @user.id} # fake login
  end

  test "should get index" do
    get :index, user_id: @user
    assert_response :success
    assert_not_nil assigns[:user]
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new, user_id: @user
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, user_id: @user, post: { body: @post.body, title: @post.title }
    end

    assert_redirected_to user_post_path(@user, assigns(:post))
  end

  test "should show post" do
    get :show, user_id: @user, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, user_id: @user, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, user_id: @user, id: @post, post: { body: @post.body, title: @post.title }
    assert_redirected_to user_post_path(@user, assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, user_id: @user, id: @post
    end

    assert_redirected_to user_posts_path(@user)
  end

  test "redirects when the specified user does not exist" do
    get :index, user_id: -1
    assert flash[:alert] == "Invalid user!"
    assert_redirected_to users_url
  end

  test "redirects when trying to edit a post for a different user" do
    other_user = users(:user_two)
    get :edit, user_id: other_user, id: @post
    assert flash[:alert] == "You are not authorized to modify that post!"
    assert_redirected_to user_posts_url(other_user)
  end
end
