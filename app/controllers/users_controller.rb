class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # refractor
    # user_params = params.require(:user).permit([:username, :email :password])

    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      # pass this key :user_id to sessions hash and give it this value @user.id
    # only difference from a standard CRUD is that after the users successfully create their user record we add sessions[:user_id] = @user.id. This way we authenticate the user to our website using the session upon successful account creation.
    redirect_to root_path, notice: "Thanks for signing up!"
    # redirect_to root_path(@user)
    # redirect to user create path
    else
    render :new
    end
  end

  def edit
    # @user = User.find params[:id]
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "account successfully updated"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  #
  # def show
  #   @user = User.find params[:id]
  # end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    # error because didn't add in the new fields in the table
  end

end
