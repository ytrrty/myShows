class Show < ActiveRecord::Base
  has_many :users_shows
  has_many :users, through: :users_shows
  has_many :episodes

  has_many :shows_genres
  has_many :genres, through: :shows_genres

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      Show.all
    end
  end

  end

