class EpisodesController < ApplicationController
  def show
    @episode = Episode.find(params[:id])
    @show = @episode.show
  end

  def mark_as_watched
    user_episode = current_user.users_episodes.find_or_initialize_by(episode_id: params[:id])
    if user_episode.id
      user_episode.destroy
    else
      user_episode.save
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
