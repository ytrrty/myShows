class CreateForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :users_shows, :shows
    add_foreign_key :users_shows, :users
    add_foreign_key :episodes, :shows
  end
end
