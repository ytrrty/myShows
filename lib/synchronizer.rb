class Synchronizer
  def perform(pages = 1)
    (1..pages).each do |page|
      shows_page = Nokogiri::HTML(open(shows_list(page)))
      shows_page.css('.lister-item-header a').each do |show|
        next unless show[:href].include?('/title/tt')
        @show_url = 'http://www.imdb.com' + show[:href]
        show_page = Nokogiri::HTML(open(@show_url))

        name = show_page.css('h1').text.strip.lstrip
        @show = Show.find_or_initialize_by(name: name)
        @show.status = show_page.css('.bp_text_only').present? ? 'Run' : 'Closed'
        @show.about = show_page.css('#titleStoryLine p').text.strip.lstrip
        @show.seasons_count = show_page.css('.clear+ div a:nth-child(1)').text.strip.lstrip
        @show.runtime = show_page.css('#title-overview-widget time').text.strip.lstrip
        @show.rate_imdb = show_page.css('strong span').text.strip.lstrip
        show_page.css('.poster img').map { |img| @show.photo = img['src'] }
        # show_page.css('#img_primary .image a').map { |orig_pic_url|
        #   orig_pic_doc = Nokogiri::HTML(open('http://www.imdb.com/' + orig_pic_url[:href]))
        #   orig_pic_doc.css('#primary-img').map { |orig_pic| @new_show.photo_orig = orig_pic[:src] }
        # }
        @show.save

        parse_genres(show_page)
        parse_episodes

        @show.start_date = @show.episodes.first.released
        @show.finish_date = @show.episodes.last.released if @show.status == 'Finished'
        @show.save
      end
    end
  end

  private

  def parse_genres(show_page)
    show_page.css('.subtext .itemprop').each do |genre|
      next if genre.text.blank?
      @genre = Genre.find_or_initialize_by(name: genre.text.strip.lstrip)
      @genre.save
      @show_genre = @show.shows_genres.find_or_initialize_by(genre_id: @genre.id)
      @show_genre.save
    end
  end

  def parse_episodes
    (1..@show.seasons_count).each do |season|
      episodes = Nokogiri::HTML(open(episodes_list(season)))
      episodes.css('.info strong a').each do |item|
        episode_url = 'https://www.imdb.com' + item[:href] #episode
        episode_page = Nokogiri::HTML(open(episode_url))
        released = episode_page.css('.subtext a~ .ghost+ a').text.strip.lstrip
        next if released.blank?
        season = episode_page.css('.bp_text_only:nth-child(1) .bp_heading').text[7]
        number = episode_page.css('.bp_text_only:nth-child(1) .bp_heading').text[18..20]
        @episode = Episode.find_or_initialize_by(show_id: @show.id, season: season, number: number)
        @episode.name = episode_page.css('h1').text.strip.lstrip
        @episode.about = episode_page.css('.summary_text').text.strip.lstrip
        @episode.released = released
        @episode.rate_imdb = episode_page.css('strong span').text.strip.lstrip
        episode_page.css('#title-overview-widget img').map { |img| @episode.photo = img['src'] }

        # episode_page.css('#img_primary .image a').map { |orig_pic_url|
        #   orig_pic_doc = Nokogiri::HTML(open('http://www.imdb.com/' + orig_pic_url[:href]))
        #   orig_pic_doc.css('#primary-img').map { |orig_pic| @new_episode.photo_orig = orig_pic[:src] }
        # }
        @episode.save
      end
    end
  end

  def shows_list(page)
    "https://www.imdb.com/search/title?num_votes=5000,&sort=moviemeter&title_type=tv_series&page=#{page}"
  end

  def episodes_list(season)
    @show_url.split('/')[0..4].join('/') + "/episodes?season=#{season}"
  end
end
