class CreateReleasers < ActiveRecord::Migration
  def change
    create_table :releasers do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end