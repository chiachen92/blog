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
    if @favourite.save
      redirect_to post_path(params[:post_id]), notice: "comment favourited"
    else
      redirect_to post_path(params[:post_id]), alert: "favorite failed"
    end
  end

  def destroy
    f = Favourite.find params[:id]
    p = f.comment.post
    f.destroy
    redirect_to post_path(p), notice: "Unfavoried"
  end

end
