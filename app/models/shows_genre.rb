class ShowsGenre < ActiveRecord::Base
  belongs_to :show
  belongs_to :genre
end
