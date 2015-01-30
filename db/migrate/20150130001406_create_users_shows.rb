class CreateUsersShows < ActiveRecord::Migration
  def change
    create_table(:user_shows) do |t|
      t.references :user, index: true
      t.references :show, index: true
      t.integer :user_id
      t.integer :show_id
      t.string :show_status
      t.boolean :favorite
    end
  end
end
