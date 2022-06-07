class Wallet < ApplicationRecord
  belongs_to :user
  has_many :nfts
  validates :wallet_key, presence: true
end
