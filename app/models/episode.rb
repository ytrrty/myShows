class Episode < ApplicationRecord
  belongs_to :show
  has_many :users_episodes
  has_many :comments, :as => :commentable

  def online_link
    return if show.online_link.blank?
    "#{show.online_link}?nocontrols=1&season=#{season}&episode=#{number}"
  end
end
