class UsersController < ApplicationController
  before_action :set_user, only: :show

  def index
    @users = User.all
  end

  def show
    @user_shows = @user.users_shows.includes(show: [:episodes, :rate_average])
    @user_episodes = @user.users_episodes.includes(episode: :show)
    @watching =      @user_shows.select_by_status('watching')
    @will_watch =    @user_shows.select_by_status('will_watch')
    @stopped_watch = @user_shows.select_by_status('stopped_watch')
    @favorites     = @user_shows.select(&:favorite?)
    @stats = {
      episodes: {
        count: @user_shows.sum {|u_s| u_s.show.episodes.size },
        watched: @user_episodes.count
      },
      hours: {
        count: @user_shows.sum { |u_s| u_s.show.episodes.size * u_s.show.runtime } / 60.0,
        watched: @user_episodes.sum { |u_e| u_e.episode.show.runtime } / 60.0
      },
      days: {
        count: @user_shows.sum { |u_s| u_s.show.episodes.size * u_s.show.runtime } / 60.0 / 24,
        watched: @user_episodes.sum { |u_e| u_e.episode.show.runtime } / 60.0 / 24
      }
    }
  end

  def favorites
    @shows = current_user.users_shows.where(favorite: true).map(&:show)
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
