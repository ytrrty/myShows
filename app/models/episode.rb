class Episode < ApplicationRecord
  belongs_to :show
  has_many :users_episodes
  has_many :comments, :as => :commentable

  ratyrate_rateable 'rate'

  def online_link(autoplay = true)
    return if show.online_link.blank?
    "#{show.online_link}?nocontrols=1&autoplay=#{autoplay ? 1 : 0}&season=#{season}&episode=#{number}"
  end
end
