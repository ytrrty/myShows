class CreateUsersShows < ActiveRecord::Migration
  def change
    create_table(:users_shows) do |t|
      t.references :user, index: true
      t.references :show, index: true
      t.string :show_status
      t.boolean :favorite, default: false
    end
  end
end
