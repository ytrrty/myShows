class CreateShowsGenres < ActiveRecord::Migration
  def change
    create_table :shows_genres do |t|
      t.references :show,  index: true
      t.references :genre, index: true
    end
  end
end
