class ShowSearch < BaseSearch
  def base_query
    Show.left_joins(:genres).distinct
  end

  def search_name
    name = "%#{options[:name]}%"
    query.where('shows.name ILIKE ? OR shows.about ILIKE ?', name, name)
  end

  def search_genre_id
    query.where(genres: { id: options[:genre_id] })
  end

  def search_order
    case options[:order].to_sym
    when :name_desc
      query.order('shows.name DESC')
    when :name_asc
      query.order('shows.name ASC')
    when :rate_desc
      query.order('shows.rate_imdb DESC')
    when :rate_asc
      query.order('shows.rate_imdb ASC')
    else
      query
    end
  end
end
