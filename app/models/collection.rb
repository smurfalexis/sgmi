class Collection < ApplicationRecord
  has_many :nfts
  has_one :photo
  CATEGORIES = ["Gaming", "Music", "Sports", "Art",
    "Utility", "Metaverse"]


  include PgSearch::Model
  pg_search_scope :search_by_keyword,
    against: [ :name, :category, :description],
    using: {
      tsearch: { prefix: true }
    }
end
