require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @valid_attrs = {email: "some content", password: "some content", password_confirmation: "some content", username: "some content"}
    @invalid_attrs = {}
  end

  test "changeset with valid attributes" do
    user = User.new(@valid_attrs)
    assert user.valid?
  end

  test "changeset with invalid attributes" do
    user = User.new(@invalid_attrs)
    refute user.valid?
  end

  test "password_digest value gets set to a hash" do
    user = User.create(@valid_attrs)
    assert user.password_digest.length == 60
    # I know, weak test, but has_secure_password does work,
    # have it here jus to mirror the Phoenix version
  end

  test "password_digest value does not get set if password is nil" do
    user = User.create(email: "test@test.com", password: nil, password_confirmation: nil, username: "test")
    assert user.password_digest.nil?
  end
end
