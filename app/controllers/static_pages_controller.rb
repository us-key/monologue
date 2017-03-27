class StaticPagesController < ApplicationController

  skip_before_action :logged_in_user

  def home

    # ログイン済みの場合Postsページにリダイレクトする
    if logged_in?
      redirect_to posts_url
    end
  end

end
