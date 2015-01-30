class Episode < ActiveRecord::Base
  has_many :shows_episodes
  has_many :shows, through: :shows_episodes
end
