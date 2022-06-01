class AddWebsiteToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :website, :string
  end
end
