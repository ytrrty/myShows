class ShowsGenre < ApplicationRecord
  belongs_to :show
  belongs_to :genre
end
