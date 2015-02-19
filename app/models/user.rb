class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :users_shows
  has_many :shows, through: :users_shows

  has_many :users_episodes

  has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '100x100>', :default_url => '/default/missing.png' }
  validates_attachment :avatar,
                       :content_type => { :content_type => ['image/jpeg', 'image/gif', 'image/png'] },
                       :size => { :in => 0..1000.kilobytes }
end
