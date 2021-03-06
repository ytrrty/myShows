class CreateEpisodes < ActiveRecord::Migration[4.2]
  def change
    create_table :episodes do |t|
      t.string :name,               null: false
      t.text   :about,              null: false
      t.date   :released
      t.float :rate_imdb
      t.references :show,           show: true
      t.integer :season,            null: false
      t.integer :number,            null: false
      t.integer :comments_count,    default: 0
      t.string :photo
      t.string :photo_orig
    end
  end
end
