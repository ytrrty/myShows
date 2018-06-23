class Comment < ApplicationRecord
  belongs_to :commentable, :polymorphic => true
  has_many :comments, as: :commentable
  belongs_to :user

  validates_presence_of :body, :user, :commentable

  def show
    return @show if defined?(@show)
    @post = commentable.is_a?(Show) ? commentable : commentable.show
  end
end
