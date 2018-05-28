class Episode < ApplicationRecord
  belongs_to :show
  has_many :users_episodes
  has_many :comments, :as => :commentable
end
