class PostsController < ApplicationController

POSTS_PER_PAGE = 5
before_action :authenticate_user, except: [:index, :show]
# it's okay to show the user the list and the individual product info

before_action :authorize_access, only: [:update, :edit, :destroy]
# only authorized access to edit update destroy actions for products

# can refractor code later: private
#   def find_post
#     @post = Post.find params[:id]
#   end

#   def post_params

#     params.require(:post).permit(:title, :body)
#
  # end
#
#
#
# end
#   To make sure that a user is authenticated before accessing a specific controller action we simply add a before_action as in:
# ruby before_action :authenticate_user!, except: [:index, :show]
# Which will redirect the user to the sign in page if they are not authenticated. Index and show won't need authentication.

  # creates new post, displays a form
  def new
    @post = Post.new
    @category = Category.new
  end

  # form submitted in the new action will need to submit to create action in order to create the post

  # create action handles the post after the form has been submitted


  def create
    post_params = params.require(:post).permit([:title, :body, :user_id])
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      flash[:success] = "Post was successfully created"
      redirect_to post_path(@post)
      # redirect to show page with this post id
    else
      render :new
    end
  end

  def show
    @post = Post.find params[:id]
    # can refractor this and add before_action :find_posts, only: [:show, :edit, :update, :destroy] and make a private method called def find_post
    @comment = Comment.new

  end

  def index
    # @posts = Post.order(created_at: :desc)
      @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: POSTS_PER_PAGE)
    # @comments = Comment.order(created_at: :desc)
    # @posts = Post.search(params[:search])
  end
  #   # @post = Post.order(created_at: :desc).limit(POSTS_PER_PAGE).offset(@page.to_i * POSTS_PER_PAGE)
  #   # @post = Post.search(params[:search])
  # end
  def edit
    @post = Post.find params[:id]
    # authorize_access
  end

  def update
    # we use the require with permit technique to enforce using only the parameters we allow the user to change which are the title and body. We then find the question by its id and update it with the parameters using the ActiveRecord update method. After that, we redirect to show page
    post_params= params.require(:post).permit([:title, :body, :user_id])
    @post = Post.find params[:id]
    if (can? :modify, @post) && (@post.update post_params)
      flash[:success] = "Post was successfully updated"
      redirect_to post_path(@post)
      # redirect to show page displaying the post with the updated changes
    else
      render :edit
      # doesn't fit the params try the same edit page again
    end
  end

  def destroy
    @post = Post.find params[:id]
    if can? :modify, @post
      @post.destroy
      flash[:danger] = "Post was deleted"
      redirect_to posts_path
    else
      render :show
    end
    # redirect to post listing page
  end

  private

  # def authorize_access
  #   redirect_to root_path, alert: "Access Denied" unless can? :modify, Post
  # end
  # right now it's calling :modify on a Post which is a class so all the Post made can take in the method modify

  # if i change Post to @post would it just call method on the specific post?

  def authorize_access
    # byebug
    redirect_to root_path, alert: "Access Denied" unless can? :modify, Post
  end




end
