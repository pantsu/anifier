class AddLinksToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :download_url, :string
    add_column :releases, :details_url, :string
  end
end
