class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :change_status]
  
  def show
    @show_genres = @show.genres
  end

  def index
    @all_shows = Show.all.page(params[:page]).per(20).search(params[:search])
  end

  def change_status
    @update_record = UsersShow.where(:user_id => current_user.id, :show_id => Show.find(params[:id]))
    unless @update_record.empty?
      if params[:status] == 'dont_watch'
        UsersShow.destroy(@update_record)
      elsif
        UsersShow.update(@update_record, :show_status => params[:status])
      end
    else
      @new_record = UsersShow.new
      @new_record.user_id = current_user.id
      @new_record.show = Show.find(params[:id])
      @new_record.show_status = params[:status]
      @new_record.save
    end
    redirect_to :back
  end

  def new
    #for n in 1..10 do
      url = 'http://www.imdb.com/search/title?num_votes=5000%2C&sort=moviemeter&title_type=tv_series'
      doc = Nokogiri::HTML(open(url))
      doc.css('.title a').each do |item|
        if (item[:href].include? '/title/tt') && (item[:href].length < 25)
          @new_show = Show.new
          @new_show.name = item.content
          show_url = 'http://www.imdb.com/' + item[:href]
          show_doc = Nokogiri::HTML(open(show_url))
          show_doc.css('.txt-block:nth-child(4) a').each do |element|
            @new_show.country = element.content
          end
          if show_doc.css('.header .nobr').text[6] != ' '
            @new_show.status = 'Closed'
          else
            @new_show.status = 'Run'
          end
            @new_show.start_date = show_doc.css('.header .nobr').text[1..4]
            @new_show.finish_date = ''
            @new_show.channel = ''
            @new_show.about = show_doc.css('#titleStoryLine p').text
            @new_show.seasons_count = show_doc.css('.clear+ div a:nth-child(1)').text
            @new_show.runtime = show_doc.css('#overview-top time').text
            @new_show.rate_imdb = show_doc.css('.star-box-giga-star').text
            @new_show.rate_users = 0.1
            @new_show.comments_count = 0
          show_doc.css('#img_primary img').each do |img| @new_show.photo = img['src'] end
          @new_show.save

          show_doc.css('.infobar .itemprop').each do |element|
            @new_genre = ShowsGenre.new
            @genre = Genre.where(:name => element.text)
            @new_genre.show_id = @new_show.id
            @new_genre.genre_id = @genre.ids[0]
            @new_genre.save
        end
      end
    end
  end
  
  private
    def set_show
      @show = Show.find(params[:id])
    end
end
