class Collection < ApplicationRecord
  has_many :nfts
  has_one :photo
  CATEGORIES = ["Gaming", "Music", "Sports", "Art",
    "Utility", "Metaverse"]
end
