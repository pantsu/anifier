class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, null: false
      t.references :title, null: false
      t.references :releaser, null: false
      t.references :release, null: false

      t.timestamps
    end
  end
end
