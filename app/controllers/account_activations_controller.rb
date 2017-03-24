class AccountActivationsController < ApplicationController

  skip_before_action :logged_in_user

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = "Account activated!"
      redirect_to login_path
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
