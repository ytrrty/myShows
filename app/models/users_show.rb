class UsersShow < ApplicationRecord
  belongs_to :user
  belongs_to :show

  def self.select_by_status(status)
    select { |user_show| user_show.show_status == status }
  end
end
