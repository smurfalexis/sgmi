class CreateWatchlistItems < ActiveRecord::Migration[6.1]
  def change
    create_table :watchlist_items do |t|
      t.references :watchlist
      t.references :collection
      t.timestamps
    end
  end
end
