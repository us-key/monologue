class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザーログイン画面にリダイレクトする
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    # ログイン状態の場合のみログアウト処理
    log_out if logged_in?
    redirect_to root_url
  end
end
