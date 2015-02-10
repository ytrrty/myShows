class GenresController < ApplicationController
  def new
    url = 'http://www.imdb.com/genre'
    doc = Nokogiri::HTML(open(url))
    doc.css('#main a').each do |item|
      @new_genre = Genre.new
      @new_genre.name = item.text
      @new_genre.save
    end
  end
end
