class AddIndexToTweetsBody < ActiveRecord::Migration[7.2]
  def change
    add_index :tweets, :body
  end
end
