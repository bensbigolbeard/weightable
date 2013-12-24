class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user, index: true
      t.integer :friend_id

      t.timestamps
    end
  end
end
