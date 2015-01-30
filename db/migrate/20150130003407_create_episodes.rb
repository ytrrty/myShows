class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.string :about
      t.float :rate_imdb
      t.float :users_rate
      t.integer :comments_count
      t.timestamps null: false
    end
  end
end
