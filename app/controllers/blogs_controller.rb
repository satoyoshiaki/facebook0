class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy ]
  before_action :login_judge, only: [:create, :edit, :update, :destroy, :new, :show ]
  def index
    @blogs = Blog.all
  end  
  def new
    # @blog = Blog.new
    @blog = current_user.blogs.build
  end
  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end
  def create
    # @blog = Blog.new
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        BlogMailer.blog_mail(@blog).deliver
        redirect_to blogs_path, notice: "投稿を作成しました！"
      else
        render :new
      end
    end
  end
  def edit
    @blog = Blog.find(params[:id])
  end
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "投稿を編集しました！"
    else
      render :edit
    end
  end
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"投稿を削除しました！"
  end
  def favorites_index
    # @blog = Blog.find(params[:id])
    # @blog = current_user.favorite_blogs.order(created_at: "DESC")
    @user = User.find(params[:id])
    @blog = Blog.where(user_id: @user.id)
  end
  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end
  private
  def blog_params
    params.require(:blog).permit(:image, :image_cache, :content)
  end
  def set_blog
    @blog = Blog.find(params[:id])
    unless current_user == @blog.user
      redirect_to blogs_path, notice: "他人の投稿はいじれません"
    end
  end
  def login_judge
    unless logged_in?
      redirect_to new_session_path
    end
  end
end