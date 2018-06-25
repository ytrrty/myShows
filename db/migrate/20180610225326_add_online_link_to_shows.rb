class AddOnlineLinkToShows < ActiveRecord::Migration[5.2]
  def change
    add_column :shows, :online_link, :string
  end
end
