class AddIndexes < ActiveRecord::Migration
  def change
    add_index :releases, :releaser_id
    add_index :releases, :title_id
    add_index :releases, [:releaser_id, :title_id], unique: true

    add_index :releasers, :name, unique: true
    add_index :titles, :name, unique: true

    add_index :subscriptions, :user_id
    add_index :subscriptions, :title_id
    add_index :subscriptions, :releaser_id
    add_index :subscriptions, [:user_id, :title_id]
    add_index :subscriptions, [:user_id, :title_id, :releaser_id], unique: true

    add_index :notifications, [:user_id, :release_id], unique: true
  end
end
