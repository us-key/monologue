class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :logged_in_user
  after_action :discard_flash_if_xhr

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  protected
    def discard_flash_if_xhr
      flash.discard if request.xhr?
    end
end
