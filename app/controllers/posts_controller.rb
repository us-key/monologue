class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @today_posts = current_user.posts
      .where(created_at: Time.current.beginning_of_day..Time.current)
      .paginate(page: params[:page])
    @lastweek_posts = current_user.posts
      .where(created_at: 7.days.ago.beginning_of_day..1.days.ago.end_of_day)
      .paginate(page: params[:page])
    # TODO ループ回せたらよいが一旦はゴリゴリ実装
    @past_1_days_ago_posts = current_user.posts
      .where(created_at: 1.days.ago.beginning_of_day..1.days.ago.end_of_day)
      .paginate(page: params[:page])
    @past_2_days_ago_posts = current_user.posts
      .where(created_at: 2.days.ago.beginning_of_day..2.days.ago.end_of_day)
      .paginate(page: params[:page])
    @past_3_days_ago_posts = current_user.posts
      .where(created_at: 3.days.ago.beginning_of_day..3.days.ago.end_of_day)
      .paginate(page: params[:page])
    @past_4_days_ago_posts = current_user.posts
      .where(created_at: 4.days.ago.beginning_of_day..4.days.ago.end_of_day)
      .paginate(page: params[:page])
    @past_5_days_ago_posts = current_user.posts
      .where(created_at: 5.days.ago.beginning_of_day..5.days.ago.end_of_day)
      .paginate(page: params[:page])
    @past_6_days_ago_posts = current_user.posts
      .where(created_at: 6.days.ago.beginning_of_day..6.days.ago.end_of_day)
      .paginate(page: params[:page])
    @past_7_days_ago_posts = current_user.posts
      .where(created_at: 7.days.ago.beginning_of_day..7.days.ago.end_of_day)
      .paginate(page: params[:page])

    # ログインユーザーの利用タグTOP10を取得しHashにセット
    con = ActiveRecord::Base.connection
    sqlStr = "select t.name, count(t.name) as cnt
              from posts p, tags t, taggings ts
              where p.id=ts.taggable_id
              and    ts.tag_id=t.id
              and user_id=#{current_user.id}
              group by t.name
              order by count(t.name) desc;"
    @tags = con.select_all(sqlStr).to_hash
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        flash[:success] = "Post was successfully created."
        format.html { redirect_to posts_url }
        #format.json { render :no_content }
        format.js
      else
        format.html { render :index }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /posts/search
  # POST /posts/search.json
  def search
    created_from = params[:created_from]
    created_to = params[:created_to]
    @tags = params[:tags]
    content = params[:content]
    @posts = current_user.posts
      .created_between(created_from, created_to)
      .content_like(content)
      .find_by_tag(@tags)
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:success] = "Post was successfully updated."
        format.html { redirect_to posts_url }
        format.json { render :show, status: :ok, location: posts_url }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      flash[:success] = "Post was successfully destroyed."
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :user_id, :label_list)
    end

end
