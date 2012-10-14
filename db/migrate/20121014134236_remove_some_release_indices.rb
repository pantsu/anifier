class RemoveSomeReleaseIndices < ActiveRecord::Migration
  def up
    add_index :releases, :raw, unique: true
    remove_index :releases, name: "index_releases_on_releaser_id_and_title_id"
  end

  def down
    remove_index :releases, :raw
    add_index :releases, [:releaser_id, :title_id], unique: true
  end
end
