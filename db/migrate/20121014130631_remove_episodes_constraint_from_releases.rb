class RemoveEpisodesConstraintFromReleases < ActiveRecord::Migration
  def up
    change_column_null :releases, :episodes, true
  end

  def down
    change_column_null :releases, :episodes, false
  end
end
