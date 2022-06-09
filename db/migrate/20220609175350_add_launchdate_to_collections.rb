class AddLaunchdateToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :launchdate, :date
  end
end
