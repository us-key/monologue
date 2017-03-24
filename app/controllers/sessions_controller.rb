class SessionsController < ApplicationController

  skip_before_action :logged_in_user

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にPosts画面にリダイレクトする
      if user.activated?
        message = "Successfully logged in."
        flash[:success] = message
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to posts_path
      else
        message = "Account not activated."
        message +=  "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    # ログイン状態の場合のみログアウト処理
    log_out if logged_in?
    redirect_to root_url
  end
end
