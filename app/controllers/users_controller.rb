class UsersController < ApplicationController

  def show
    @user_profile = User.find(params[:id])
    @watching = UsersShow.where(:user_id => @user_profile.id, :show_status => 'watching')
    @will_watch = UsersShow.where(:user_id =>  @user_profile.id, :show_status => 'will_watch')
    @stopped_watch = UsersShow.where(:user_id =>  @user_profile.id, :show_status => 'stopped_watch')
    #@ord = ShowsGenre.group(:genre_id).count
=begin
    @ord = ShowsGenre.group(:genre_id).count

    @result = Array.new(Genre.count).map! {0}
    @userShows = @user_profile.users_shows.includes(:show).where(show_status: :watching)
    @genres = Genre.all
    @userShows.each do |val|
      val.show.genres.each do |v|
        @result[v.id] = 0.to_i if @result[v.id].nil?
        @result[v.id]  = @result[v.id] + 1
      end
    end
=end

    @ord = Genre.group('genres.name').joins('
          INNER JOIN shows_genres ON shows_genres.genre_id = genres.id
          INNER JOIN shows ON shows.id = shows_genres.show_id
          INNER JOIN users_shows ON users_shows.show_id = shows.id
          INNER JOIN users ON users.id = users_shows.user_id').
          where('users.id = ' + params[:id].to_s).count

    # @result.each_with_index { |val, i| puts "Genre: #{Genre.find(i).name} - #{val}" if !val.nil? }

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

  private
end

