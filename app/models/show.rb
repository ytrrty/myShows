class Show < ActiveRecord::Base
  has_many :user_shows
  has_many :users, through: :user_shows
end
