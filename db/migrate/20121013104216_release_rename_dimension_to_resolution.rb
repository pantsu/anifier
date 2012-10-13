class ReleaseRenameDimensionToResolution < ActiveRecord::Migration
  def change
    rename_column :releases, :dimension, :resolution
  end
end
