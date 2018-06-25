class CreateUsersEpisodes < ActiveRecord::Migration[4.2]
  def change
    create_table :users_episodes do |t|
      t.references :episode, show: true
      t.references :user, show: true
      t.boolean :favorite, default: false
    end
    add_foreign_key :users_episodes, :episodes
    add_foreign_key :users_episodes, :users
  end
end
