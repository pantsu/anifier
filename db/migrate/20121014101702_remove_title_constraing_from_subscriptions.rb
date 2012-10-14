class RemoveTitleConstraingFromSubscriptions < ActiveRecord::Migration
  def up
    change_column_null :subscriptions, :title_id, true
  end

  def down
    change_column_null :subscriptions, :title_id, false
  end
end
