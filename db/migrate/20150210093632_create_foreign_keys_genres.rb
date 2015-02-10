class CreateForeignKeysGenres < ActiveRecord::Migration
  def change
    add_foreign_key :shows_genres, :genres
    add_foreign_key :shows_genres, :shows
  end
end
