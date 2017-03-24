require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:testuser)
    @post = @user.posts.build(content: "testpost")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = nil
    assert_not @post.valid?
  end

  test "content should be at most 100 characters" do
    @post.content = "a" * 101
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end
