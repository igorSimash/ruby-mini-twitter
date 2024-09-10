class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true
      t.datetime :created_at, null: false
    end

    add_index :likes, [ :user_id, :tweet_id ], unique: true
  end
end
