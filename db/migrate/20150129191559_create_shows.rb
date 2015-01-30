class CreateShows < ActiveRecord::Migration
  def change
    create_table(:shows) do |t|
      t.string :status,               null: false, default: ""
      t.date :start_date
      t.date :finish_date
      t.string :country,              null: false, default: ""
      t.string :channel,              null: false, default: ""
      t.string :about,                null: false, default: ""
      t.integer :seasons_count
      t.integer :runtime
      t.float :rate_imdb
      t.float :rate_users
      t.integer :genre_id
      t.integer :comments_count
    end

  end
end
