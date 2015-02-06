class ShowsController < ApplicationController
  def show
    @show_page = Show.find(params[:id])
  end

  def new

    #for n in 1..10 do
    #n=1
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
            @new_show.status = 'Run'
            @new_show.start_date = ''
            @new_show.finish_date = ''
            @new_show.channel = ''
            @new_show.about = show_doc.css('#titleStoryLine p').text
            @new_show.seasons_count = show_doc.css('.clear+ div a:nth-child(1)').text
            @new_show.runtime = show_doc.css('#overview-top time').text
            @new_show.rate_imdb = show_doc.css('.star-box-giga-star').text
            @new_show.rate_users = 0.1
            @new_show.comments_count = 0
          @new_show.save




=begin
              :name => item.content,
              :status => item[:href],
              :start_date => '',
              :finish_date => '',
              :country => 1,
              :channel => 1,
              :about => 'element',
              :seasons_count => 1,
              :runtime => 1,
              :rate_imdb => 1,
              :rate_users => 1,
              :comments_count => 1)
              @new_show.save
=end
        #end

      end
    end
  end
  end
