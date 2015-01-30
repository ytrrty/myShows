class ShowsEpisode < ActiveRecord::Base
  belongs_to :show
  belongs_to :episode

  belongs_to :user
end
