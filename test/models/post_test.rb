require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @valid_attr = {body: "some content", title: "some content"}
    @invalid_attr = {}
  end

  test "with valid attributes" do
    post = Post.new(@valid_attr)
    assert post.valid?
  end

  test "with invalida attributes" do
    post = Post.new(@invalid_attr)
    refute post.valid?
  end 
end
