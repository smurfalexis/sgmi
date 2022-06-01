class Collection < ApplicationRecord
  has_many :nfts
  CATEGORIES = ["Gaming", "Music", "Sports", "Art",
    "Utility", "Metaverse"]

end
