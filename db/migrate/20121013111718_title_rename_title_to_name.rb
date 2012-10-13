class TitleRenameTitleToName < ActiveRecord::Migration
  def up
    rename_column :titles, :title, :name
  end
end
