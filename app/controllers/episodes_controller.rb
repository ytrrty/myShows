class EpisodesController < ApplicationController
  def new

    all_url = 'http://www.imdb.com/search/title?num_votes=5000%2C&sort=moviemeter&title_type=tv_series' #showlist
    Nokogiri::HTML(open(all_url)).css('.title a').each do |show|
      if (show[:href].include? '/title/tt') && (show[:href].length < 25)
        show_url = 'http://www.imdb.com/' + show[:href] #show
        show_doc = Nokogiri::HTML(open(show_url))
        seasons_count = show_doc.css('.clear+ div a:nth-child(1)').text.to_i
        show_name = show_doc.css('.header .itemprop').text

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
            @new_episode.users_rate = seasons_count
            @new_episode.comments_count = 0
            @new_episode.show_id = Show.where(name: show_name).first
            @new_episode.season = episode_doc.css('.tv_header .nobr').text[7]
            @new_episode.number = episode_doc.css('.tv_header .nobr').text[18..20]
            unless @new_episode.released.nil? then @new_episode.save end
          end
        end
      end
    end
    redirect_to :back
  end
end
