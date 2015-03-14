class Show < ActiveRecord::Base
  has_many :users_shows
  has_many :users, through: :users_shows
  has_many :episodes

  has_many :shows_genres
  has_many :genres, through: :shows_genres
  has_many :comments, :as => :commentable

  letsrate_rateable "rate"

  def self.search(search)
    if search
      where('`shows`.`name` LIKE ? OR `shows`.`about` LIKE ?', "%#{search}%", "%#{search}%")
    else
      Show.all
    end
  end

  def self.sort(sort)
      case sort
        when 'name_desc'
          return self.order('`shows`.`name` DESC')
        when 'name_asc'
          return self.order('`shows`.`name` ASC')
        when 'rate_desc'
          order('`shows`.`rate_imdb` DESC')
        when 'rate_asc'
          order('`shows`.`rate_imdb` ASC')
    else
      Show.all
    end
  end

  def self.genre(genre)
    if genre
      if genre == 'all'
        Show.all
      else
      Show.joins(:genres).where('`genre_id` = ' + genre)
      end
    else
      Show.all
    end
  end

  end

