class UsersController < ApplicationController
  before_action :set_user, only: :show

  def show
    @user_shows = @user.users_shows
    @watching =      @user_shows.select_by_status(:watching)
    @will_watch =    @user_shows.select_by_status(:will_watch)
    @stopped_watch = @user_shows.select_by_status(:stopped_watch)

    @ord = Genre.joins(shows_genres: [show: [users_shows: :user]])
                .where(users_shows: { user_id: @user.id })
                .where.not(users_shows: { show_status: :dont_watch})
                .group('genres.name')
                .count
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
    @rated_shows = Array.new

    rate = Rate.where(:rater_id => current_user.id)
    rate.each {|rate|
      if rate.rateable_type == 'Show'
        @rated_shows.push(Show.find(rate.rateable_id))
      end
    }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

