class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :change_status]
  before_action :shows_list, only: [:index, :list]

  def index; end

  def show
    @show_genres = @show.genres
    @episodes = @show.episodes.where.not(released: nil).order(released: :desc).order(number: :desc)
    return if current_user.blank?
    @user_episodes = current_user.users_episodes.left_joins(:episode).where(episodes: { show: @show })
    @user_show = current_user.users_shows.find_by(show: @show) if current_user.present?
  end

  def change_status
    user_show = current_user.users_shows.find_or_initialize_by(show_id: @show.id)
    user_show.show_status = params[:status]
    user_show.save
    redirect_back fallback_location: root_path
  end

  def new
    Synchronizer.new.perform
    redirect_back fallback_location: root_path
  end

  def to_favorite
    user_show = current_user.users_shows.find_or_initialize_by(show_id: params[:id])
    user_show.show_status = :dont_watch unless user_show.id
    user_show.favorite = params[:favorite]
    user_show.save
    render json: :success
  end

  def list
    render action: 'index', layout: false
  end

  private

  def set_show
    @show = Show.find(params[:id])
  end

  def shows_list
    @shows = ShowSearch.new(params).results.page(params[:page]).per(20).includes(:genres)
  end
end
