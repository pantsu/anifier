class NotificationRemoveUnusedKeys < ActiveRecord::Migration
  def change
    remove_column :notifications, :releaser_id
    remove_column :notifications, :title_id
  end
end
