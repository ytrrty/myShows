class UsersController < ApplicationController

  def show

  end

  def welcome
    redirect_to current_user if user_signed_in?
  end

end
