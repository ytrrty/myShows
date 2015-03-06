class Episode < ActiveRecord::Base
  belongs_to :show
  has_many :comments, :as => :commentable
end
