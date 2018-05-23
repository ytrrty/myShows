class CreateUsersShows < ActiveRecord::Migration[4.2]
  def change
    create_table(:users_shows) do |t|
      t.references :user, show: true
      t.references :show, show: true
      t.string :show_status
      t.boolean :favorite, default: false
    end
  end
end
