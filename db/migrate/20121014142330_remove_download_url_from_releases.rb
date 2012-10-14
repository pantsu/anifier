class RemoveDownloadUrlFromReleases < ActiveRecord::Migration
  def up
    remove_column :releases, :download_url
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
