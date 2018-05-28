class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :change_status]

  def index
    @shows = ShowSearch.new(params).results.page(params[:page]).per(20).includes(:genres)
    @genres = Genre.all
  end

  def show
    @show_genres = @show.genres
    @user_show = current_user.users_shows.find_by(show: @show) if current_user.present?
    @show_episodes = @show.episodes.order('released desc')
    @show.finish_date.nil? ? finish_year = '...' : finish_year = @show.finish_date.strftime('%Y')
    @show_years = '(' + @show.start_date.strftime('%Y') + ' - ' + finish_year + ')'
    @recommendation = Show.joins(:genres).where("genres.name IN ('#{@show.genres.pluck(:name).join("','")}')").first(6)#.group_by{ |x| x}.sort_by{ |x, list| [-list.size,x]}.map(&:first).first(6)
    @current_fav = UsersShow.where(:user_id => current_user.id, :show_id => @show.id).first if user_signed_in?
  end

  def change_status
    user_show = current_user.users_shows.find_or_initialize_by(show_id: @show.id)
    user_show.show_status = params[:status]
    user_show.save
    redirect_back fallback_location: root_path
  end

  def new
    #for n in 1..10 do
      url = 'http://www.imdb.com/search/title?num_votes=5000%2C&sort=moviemeter&title_type=tv_series'
      doc = Nokogiri::HTML(open(url))
      doc.css('.lister-item-header a').each do |item|
        if item[:href].include?('/title/tt')
          @new_show = Show.new
          show_url = 'http://www.imdb.com/' + item[:href]
          show_doc = Nokogiri::HTML(open(show_url))
          @new_show.name = show_doc.css('h1').text.strip
          @new_show.status = show_doc.css('.bp_text_only').present? ? 'Run' : 'Closed'
          @new_show.about = show_doc.css('#titleStoryLine p').text.strip
          @new_show.seasons_count = show_doc.css('.clear+ div a:nth-child(1)').text.strip
          @new_show.runtime = show_doc.css('#title-overview-widget time').text.strip
          @new_show.rate_imdb = show_doc.css('strong span').text.strip
          show_doc.css('.poster img').map { |img| @new_show.photo = img['src'] }
          # show_doc.css('#img_primary .image a').map { |orig_pic_url|
          #   orig_pic_doc = Nokogiri::HTML(open('http://www.imdb.com/' + orig_pic_url[:href]))
          #   orig_pic_doc.css('#primary-img').map { |orig_pic| @new_show.photo_orig = orig_pic[:src] }
          # }
          @new_show.save

          show_doc.css('.subtext .itemprop').each do |element|
            next if element.text.blank?
            @genre = Genre.find_or_initialize_by(name: element.text.strip)
            @genre.save
            @show_genre = @new_show.shows_genres.new(genre: @genre)
            @show_genre.save
          end
        end
      end
      redirect_back fallback_location: root_path
  end

  def to_favorite
    user_show = current_user.users_shows.find_or_initialize_by(show_id: params[:id])
    user_show.show_status = :dont_watch unless user_show.id
    user_show.favorite = params[:favorite]
    user_show.save
    render json: :success
  end

  private

  def set_show
    @show = Show.find(params[:id])
  end
end
