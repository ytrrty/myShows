class UsersController < ApplicationController

  def show
    @users = User.all
  end

  def welcome

    redirect_to current_user if user_signed_in?
  end

  def index
    @users = User.all
  end

  def edit

  end
end
