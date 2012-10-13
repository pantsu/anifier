class ReleaseRenameEpisodeToEpisodes < ActiveRecord::Migration
  def change
    rename_column :releases, :episode, :episodes
  end
end