class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :wallets
  has_many :nfts, through: :wallets
  has_one :watchlist
  after_create { |record| record.create_watchlist }
end
