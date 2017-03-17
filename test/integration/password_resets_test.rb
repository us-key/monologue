require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:testuser)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # メールアドレスが無効
    post password_resets_path, params: {password_reset: {email: ""}}
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # メールアドレスが有効
    post password_resets_path, params: {password_reset: {email: @user.email}}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
