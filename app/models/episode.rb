class Episode < ApplicationRecord
  belongs_to :show
  has_many :comments, :as => :commentable
end
