class EpisodesController < ApplicationController
  def show
    @episode = Episode.find(params[:id])
    @show = @episode.show
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
                    .where(users_shows: { show_status: 'watching' })
                    .where.not(users_shows: { id: nil })
                    .where(users_episodes: { id: nil })
                    .where('episodes.released < ?', Time.zone.now)
                    .includes(:show)
                    .order(released: :desc)
                    .order(number: :desc)
  end
end
