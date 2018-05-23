class Genre < ApplicationRecord
  has_many :shows_genres
  has_many :shows, through: :shows_genres
end
