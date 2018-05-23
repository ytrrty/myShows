class CreateForeignKeysGenres < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :shows_genres, :genres
    add_foreign_key :shows_genres, :shows
  end
end
