class Wallet < ApplicationRecord
  belongs_to :user
  has_many :nfts , dependent: :delete_all
  validates :wallet_key, presence: true
end
