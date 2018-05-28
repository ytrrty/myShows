class GenresController < ApplicationController
  def new
    url = 'https://www.imdb.com/feature/genre/'
    doc = Nokogiri::HTML(open(url))
    doc.css('#main a').each do |item|
      next if item.text.blank?
      @new_genre = Genre.find_or_initialize_by(name: item.text)
      @new_genre.save
    end
    redirect_back fallback_location: root_path
  end

  def show
    @shows = Genre.find(params[:id]).shows.all.page(params[:page]).per(20)
    @current_genre = Genre.find(params[:id])
  end

  def index
    @all_genres = Genre.all
  end
end
