class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments.includes([:author])
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.new(post_params)
    post.likes_counter = 0
    post.comments_counter = 0
    post.update_posts_counter
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'New post created successfully'
          redirect_to user_post_path(current_user.id, post.id)
        else
          render :new, alert: 'Error!'
        end
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    user = User.find_by(id: post.author_id)
    user.posts_counter -=1
    post.destroy
    user.save
    redirect_to user_posts_path(user.id)
    flash[:success] = 'Post Deleted Successfully'
  end

  private

  def post_params
    params.require(:data).permit(:title, :text)
  end
end
