class CreateForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :user_shows, :shows
    add_foreign_key :user_shows, :users
  end
end
