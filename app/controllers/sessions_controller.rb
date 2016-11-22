class SessionsController < ApplicationController
# sessions controller: We utilize the @user.authenticate method, seesion controller is a session between the user and your secured system, to authenticate user
  def new
    # renders the login form
  end

  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Signed In'
    else
      flash.now[:alert] = 'Wrong credentials'
      render :new

      # @user = user for that email exists and the password is correct
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "signed out"
  end
end


# Sessions controller (a session is a 'session' between the user and your secured system)
#   def new
#     renders the login form
#   end
#   def create
#     looks up user by email, assigns to user variable
#     if the user for that email exists AND the password for that user is correct (password is available from the user variable (looked up in DB) )
#       store the user ID in the browser session
#     else
#       show form and error message
#     end
#   end
#   def destroy
#     deletes the user id from the browser session (sets it to nil)
#   end
# Applications Controller
#   def authenticate_user
#     unless the user is signed in (see: user_signedin? method) redirect to sign in form
#   end
#   def user_signed_in?
#     checks that the sessions hash has a value for the `user_id` key, and that the value is not nil
#   end
#   def current_user
#    checks if a user is signed in, if not, dont run the user lookup code, because it will break
#    when looking up `nil` (no user logged in means a session == nil)
#    for the lookup:
#     Find the user with the user_id stored in the session.
#     "cache" that value in the @current_user variable. The ||= will check if @current_user variable is set
#     if it is it will return it, if not it will set it by performing the database lookup of the user_id
#   end
