class User < ApplicationRecord
  after_create :create_watchlist
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :wallets
  has_many :nfts, through: :wallets
  has_one :watchlist


  private


  def create_watchlist
    @user = User.last
    @watchlist = Watchlist.create(user: @user)
    @user.save
  end
end
