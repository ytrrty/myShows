class BaseSearch < Searchlight::Search
  def base_query
    entity.order(:id)
  end

  def search_limit
    query.limit(options[:limit])
  end

  def search_offset
    query.offset(options[:offset])
  end

  private

  # UserSearch => User
  # You can also redefine it in children
  def entity
    self.class.name.sub('Search', '').constantize
  end
end
