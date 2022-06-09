class Watchlist < ApplicationRecord
  belongs_to :user
  has_many :collections
  has_many :watchlist_items
end
