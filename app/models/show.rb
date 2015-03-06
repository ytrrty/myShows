class Show < ActiveRecord::Base
  has_many :users_shows
  has_many :users, through: :users_shows
  has_many :episodes

  has_many :shows_genres
  has_many :genres, through: :shows_genres
  has_many :comments, :as => :commentable

  def self.search(search)
    if search
      where('name LIKE ? OR about LIKE ?', "%#{search}%", "%#{search}%")
    else
      Show.all
    end
  end

  end

