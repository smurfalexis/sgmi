class Nft < ApplicationRecord
  belongs_to :wallet
  belongs_to :collection
  has_one :photo
  RARITY = ["Common", "Uncommon", "Rare", "Epic",
    "Legendary", "Mythic"]
end
