class OnlineLinks
  def perform
    Show.all.each do |show|
      @show = show
      search_page = Nokogiri::HTML(open(search_link))
      search_result = search_page.css('.b-content__inline_item-link a')
      next if search_result.blank?
      show_url = search_result.first[:href]
      show_page = Nokogiri::HTML(open(show_url))
      iframe = show_page.css('#cdn-player').first
      online_link = iframe[:src].split('?').first

      @show.update(online_link: online_link)
    end
  end

  private

  def search_link
    link = 'http://hdrezka.ag/index.php?do=search&subaction=search&q=' + @show.name.gsub(/[ ]/, '+')
    URI.parse(URI.escape(link))
  end
end
