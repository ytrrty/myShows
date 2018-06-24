class Show < ApplicationRecord
  has_many :users_shows
  has_many :users, through: :users_shows
  has_many :episodes

  has_many :shows_genres
  has_many :genres, through: :shows_genres
  has_many :comments, :as => :commentable

  ratyrate_rateable "rate"
end
