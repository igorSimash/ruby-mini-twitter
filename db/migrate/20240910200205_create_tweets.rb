class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.bigint :origin_id, null: true
      t.datetime :created_at, null: false
    end

    add_foreign_key :tweets, :tweets, column: :origin_id
    add_index :tweets, :origin_id
  end
end
