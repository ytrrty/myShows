class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type
      t.references :comments, :user, index: true
      t.timestamps null: false
    end
    add_index :comments, [:commentable_id, :commentable_type]
    add_foreign_key :comments, :users
  end
end
