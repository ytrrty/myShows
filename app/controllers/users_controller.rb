class UsersController < ApplicationController

  def show
    @user_profile = User.find(params[:id])
  end

  def welcome
    redirect_to current_user if user_signed_in?

  end

  def index
    @users = User.all
  end

  private
end
