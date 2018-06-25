class CreateShows < ActiveRecord::Migration[4.2]
  def change
    create_table(:shows) do |t|
      t.string :name,                 null: false
      t.string :status,               null: false, default: ''
      t.date :start_date
      t.date :finish_date
      t.text :about,                  null: false
      t.integer :seasons_count,       null: false, default: 0
      t.integer :runtime,             null: false, default: 0
      t.float :rate_imdb
      t.integer :comments_count,      null: false, default: 0
      t.string :photo
      t.string :photo_orig
    end

  end
end
