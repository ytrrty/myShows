class CreateForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :user_shows, :shows
    add_foreign_key :user_shows, :users
    add_foreign_key :shows_episodes, :shows
    add_foreign_key :shows_episodes, :episodes
    add_foreign_key :shows_episodes, :users
  end
end

