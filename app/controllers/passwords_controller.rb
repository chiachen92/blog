class PasswordsController < ApplicationController
  before_action :authenticate_user

  def edit
    @user = current_user
    redirect_to root_path, alert: "don't snoope around" unless can? :manage, current_user
    # byebug
    # if @user.id != params[:user_id].to_i
    #   redirect_to root_path, alert: "Unauthorized Access"
    # end
  end

  def update
    @user = current_user
    user_password_params = params.require(:user).permit([:old_password, :password, :password_confirmation])
    if !@user.authenticate user_password_params[:old_password]
      flash[:notice] = "Old password is invalid"
      render :edit
      # i don't get the @user.update and has info
    elsif @user.update({password: user_password_params[:password], password_confirmation: user_password_params[:password_confirmation]})
      # key and value pairs
      redirect_to edit_user_path(@user),
      notice: "Password Updated"
    else
      flash[:notice] = "Password note changed."
      render :edit
    end
  end




end
