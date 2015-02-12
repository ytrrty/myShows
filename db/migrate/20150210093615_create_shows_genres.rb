class CreateShowsGenres < ActiveRecord::Migration
  def change
    create_table :shows_genres do |t|
      t.references :show,  show: true
      t.references :genre, show: true
    end
  end
end
