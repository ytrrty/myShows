class EpisodesController < ApplicationController
  before_action :authenticate_user!

  def show
    @episode = Episode.find(params[:id])
    @show = @episode.show
    return if current_user.blank?
    @user_episode = current_user.users_episodes.find_by(episode: @episode)
  end

  def mark_as_watched
    if params[:watched] == 'true'
      params[:id].each do |episode_id|
        user_episode = current_user.users_episodes.find_or_initialize_by(episode_id: episode_id)
        user_episode.save if user_episode.id.blank?
      end
    else
      current_user.users_episodes.where(episode_id: params[:id]).delete_all
    end
  end

  def what_to_see
    @shows = Episode.left_joins(:users_episodes, show: :users_shows)
                    .where(users_shows: { show_status: 'watching', user_id: current_user.id })
                    .where.not(users_shows: { id: nil })
                    .where(users_episodes: { id: nil })
                    .where('episodes.released < ?', Time.zone.now)
                    .includes(:show)
                    .order(released: :desc)
                    .order(number: :desc)
  end
end
