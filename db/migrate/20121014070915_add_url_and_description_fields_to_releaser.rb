class AddUrlAndDescriptionFieldsToReleaser < ActiveRecord::Migration
  def change
    add_column :releasers, :description, :text
    add_column :releasers, :url, :string
  end
end
