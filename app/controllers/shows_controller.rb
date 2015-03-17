class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :change_status, :favorite]

  def show
    @show_genres = @show.genres
    @show_episodes = @show.episodes.order('released desc')
    @show.finish_date.nil? ? finish_year = '...' : finish_year = @show.finish_date.strftime('%Y')
    @show_years = ' (' + @show.start_date.strftime('%Y') + ' - ' + finish_year + ')'
    @recommendation = Show.joins(:genres).where("`genres`.`name` IN ('#{@show.genres.pluck(:name).join("','")}')").group_by{ |x| x}.sort_by{ |x, list| [-list.size,x]}.map(&:first).first(6)
    @current_fav = UsersShow.where(:user_id => current_user.id, :show_id => @show.id).first if user_signed_in?
  end

  def index
    @all_shows = Show.all.page(params[:page]).per(20).search(params[:search]).sort(params[:sort]).genre(params[:genre])
    @all_genres = Genre.all
  end

  def change_status
    update_record = UsersShow.where(user_id: current_user.id, show_id: @show.id)
    unless update_record.empty?
      update_record.update(update_record, show_status: params[:status])
    else
      @new_record = UsersShow.new
      @new_record.user_id = current_user.id
      @new_record.show_id = @show.id
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
          @new_show.name = show_doc.css('.header .itemprop').text
          if show_doc.css('.header .nobr').text[6] == ' '
            @new_show.status = 'Run'
          else
            @new_show.status = 'Closed'
          end
          @new_show.about = show_doc.css('#titleStoryLine p').text
          @new_show.seasons_count = show_doc.css('.clear+ div a:nth-child(1)').text
          @new_show.runtime = show_doc.css('#overview-top time').text
          @new_show.rate_imdb = show_doc.css('.star-box-giga-star').text
          show_doc.css('#img_primary img').map { |img| @new_show.photo = img['src'] }
          show_doc.css('#img_primary .image a').map { |orig_pic_url|
            orig_pic_doc = Nokogiri::HTML(open('http://www.imdb.com/' + orig_pic_url[:href]))
            orig_pic_doc.css('#primary-img').map { |orig_pic| @new_show.photo_orig = orig_pic[:src] }
          }
          @new_show.save

          show_doc.css('.infobar .itemprop').each do |element|
            @new_genre = ShowsGenre.new
            @genre = Genre.where(name: element.text)
            @new_genre.show_id = @new_show.id
            @new_genre.genre_id = @genre.ids[0]
            @new_genre.save
          end
        end
      end
      redirect_to :back
  end

  def favorite
    favorite_update = UsersShow.where(:user_id => current_user.id, :show_id => @show.id)
    if favorite_update.empty?
      @new_fav = UsersShow.new
      @new_fav.user_id = current_user.id
      @new_fav.show_id = @show.id
      @new_fav.favorite = params[:fav]
      @new_fav.show_status = 'dont_watch'
      @new_fav.save
    else
      favorite_update.update(favorite_update, favorite: params[:fav])
    end
  end

  private
    def set_show
      @show = Show.find(params[:id])
    end

end
