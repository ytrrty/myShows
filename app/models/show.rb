class Show < ActiveRecord::Base
  has_many :users_shows
  has_many :users, through: :users_shows
  has_many :shows_episodes
  has_many :episodes, through: :shows_episodes
end
