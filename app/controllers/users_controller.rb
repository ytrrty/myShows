class UsersController < ApplicationController

  def show
    @user_profile = User.find(params[:id])
    @watching = UsersShow.where(:user_id => current_user.id, :show_status => 'watching')
    @will_watch = UsersShow.where(:user_id => current_user.id, :show_status => 'will_watch')
    @stopped_watch = UsersShow.where(:user_id => current_user.id, :show_status => 'stopped_watch')

  end

  def welcome
    redirect_to current_user if user_signed_in?

  end

  def index
    @all_users = User.all
  end

  private
end
