class WatchlistItem < ApplicationRecord
    belongs_to :watchlist
    belongs_to :collection
    validates :collection_id, :uniqueness => {:scope => :watchlist_id}
end
