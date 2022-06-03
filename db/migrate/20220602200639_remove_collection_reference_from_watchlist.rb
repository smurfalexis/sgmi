class RemoveCollectionReferenceFromWatchlist < ActiveRecord::Migration[6.1]
  def change
    remove_reference :watchlists, :collection, index: true
  end
end
