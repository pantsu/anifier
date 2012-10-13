class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.text :raw, null: false
      t.references :releaser, null: false
      t.references :title, null: false
      t.string :episode, null: false
      t.string :extension
      t.string :audio
      t.string :video
      t.string :dimension
      t.string :crc32
      t.string :volume
      t.string :source

      t.timestamps
    end
  end
end