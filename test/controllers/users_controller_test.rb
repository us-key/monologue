require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def Setup
    @user1 = users(:testuser)
    @user2 = users(:testuser2)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when logged in as other user" do
    log_in_as(@user2)
    get edit_user_path(@user1)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as other user" do
    log_in_as(@user2)
    patch user_path(@user1), params: {user: {name: @user1.name,
                                            email: @user1.email
                                            }
                                    }
    assert flash.empty?
    assert_redirect_to root_url
  end

end
