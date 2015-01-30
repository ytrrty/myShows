class CreateShows < ActiveRecord::Migration
  def change
    create_table(:shows) do |t|
      t.string :status,               null: false, default: ''
      t.date :start_date
      t.date :finish_date
      t.string :country,              null: false, default: ''
      t.string :channel,              null: false, default: ''
      t.text :about,                  null: false
      t.integer :seasons_count,       null: false, default: 0
      t.integer :runtime,             null: false, default: 0
      t.float :rate_imdb
      t.float :rate_users
      t.integer :comments_count,      null: false, default: 0
    end

  end
end
