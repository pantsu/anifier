class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false
      t.references :title, null: false
      t.references :releaser

      t.timestamps
    end
  end
end