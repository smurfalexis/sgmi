class Watchlist < ApplicationRecord
  belongs_to :user
  has_many :watchlist_items
  has_many :collections, through: :watchlist_items
end
