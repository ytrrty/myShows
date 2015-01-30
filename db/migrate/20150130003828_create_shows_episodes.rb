class CreateShowsEpisodes < ActiveRecord::Migration
  def change
    create_table :shows_episodes do |t|
      t.references :show, index: true
      t.references :episode, index: true
      t.references :user, index: true
      t.string :show_status
      t.boolean :favorite
    end
  end
end
