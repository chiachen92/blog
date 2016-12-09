class FavouritesController < ApplicationController

  def create
    # we need to associate the favourite with this user and comment
    @favourite = Favourite.new
    # @favourite = makes the new row in active record
    @favourite.user = current_user
    # @favourite.user_id = current_user.id
    # favourite made by this user
    @favourite.comment_id = params[:comment_id]
      # supply the comment id
    @favourite.save
      flash[:success] = "comment favourited"
      redirect_to post_path(params[:post_id])
  end

  def destroy
    f = Favourite.find params[:id]
    p = f.comment.post
    f.destroy
    flash[:success] = "comment unfavourited"
    redirect_to post_path(p)
  end

end
