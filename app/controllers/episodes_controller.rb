class EpisodesController < ApplicationController

  def show
    @episode = Episode.find(params[:id])
    @show = @episode.show
  end

  def new
    all_url = 'http://www.imdb.com/search/title?num_votes=5000%2C&sort=moviemeter&title_type=tv_series' #showlist
    Nokogiri::HTML(open(all_url)).css('.title a').each do |show|
      if (show[:href].include? '/title/tt') && (show[:href].length < 25)
        show_url = 'http://www.imdb.com/' + show[:href] #show
        show_doc = Nokogiri::HTML(open(show_url))
        #seasons_count = show_doc.css('.clear+ div a:nth-child(1)').text.to_i
        show_name = show_doc.css('.header .itemprop').text
        seasons_count = Show.where(name: show_name).first.seasons_count

        for i in 1..seasons_count
          season_url = 'http://www.imdb.com/' + show[:href] + 'episodes?season=' + i.to_s #season
          doc = Nokogiri::HTML(open(season_url))
          doc.css('#episodes_content strong a').each do |item|
            episode_url = 'http://www.imdb.com/' + item[:href] #episode
            episode_doc = Nokogiri::HTML(open(episode_url))
            @new_episode = Episode.new
            @new_episode.name = episode_doc.css('.header .itemprop').text
            @new_episode.about = episode_doc.css('#titleStoryLine p').text
            @new_episode.released = episode_doc.css('.header .nobr').text
            @new_episode.rate_imdb = episode_doc.css('.star-box-giga-star').text
            @new_episode.show_id = Show.where(name: show_name).first.id
            @new_episode.season = episode_doc.css('.tv_header .nobr').text[7]
            @new_episode.number = episode_doc.css('.tv_header .nobr').text[18..20]
            episode_doc.css('#img_primary img').map { |img| @new_episode.photo = img['src'] }

            episode_doc.css('#img_primary .image a').map { |orig_pic_url|
              orig_pic_doc = Nokogiri::HTML(open('http://www.imdb.com/' + orig_pic_url[:href]))
              orig_pic_doc.css('#primary-img').map { |orig_pic| @new_episode.photo_orig = orig_pic[:src] }
            }

            @new_episode.save unless @new_episode.released.nil?
          end
        end
        current_show = Show.where(name: show_name).first
        start_date = current_show.episodes.first.released
        if current_show.status == 'Finished'
          finish_date = current_show.episodes.last.released
        end
        current_show.update(start_date: start_date, finish_date: finish_date)
      end
    end
    redirect_to :back
  end
end
