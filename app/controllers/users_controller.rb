class UsersController < ApplicationController

  def show
    @user_profile = User.find(params[:id])
    @watching = UsersShow.where(:user_id => @user_profile.id, :show_status => 'watching')
    @will_watch = UsersShow.where(:user_id =>  @user_profile.id, :show_status => 'will_watch')
    @stopped_watch = UsersShow.where(:user_id =>  @user_profile.id, :show_status => 'stopped_watch')

    @ord = Genre.group('genres.name').joins('
          INNER JOIN shows_genres ON shows_genres.genre_id = genres.id
          INNER JOIN shows ON shows.id = shows_genres.show_id
          INNER JOIN users_shows ON users_shows.show_id = shows.id
          INNER JOIN users ON users.id = users_shows.user_id').
          where('users.id = ' + params[:id].to_s + " AND users_shows.show_status != 'dont_watch'").count
  end

  def welcome
    redirect_to current_user if user_signed_in?
  end

  def index
    @all_users = User.all
  end

  def favorites
    @user_favorite = UsersShow.where(:user_id => current_user.id, :favorite => 1)
  end

  def rates
    @rate_shows = Array.new

    rate = Rate.where(:rater_id => current_user.id)
    rate.each {|rate|
      if rate.rateable_type == 'Show'
        @rate_shows.push(Show.find(rate.rateable_id))
      end
    }
  end

  private
end

