# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

SolanaTimestamp.destroy_all
Nft.destroy_all
Collection.destroy_all
Wallet.destroy_all
User.destroy_all

csv_solana = File.read(Rails.root.join('db/solana_prices.csv'))
solana_history = CSV.parse(csv_solana, headers: true, encoding: 'ISO-8859-1')

solana_history.each do |row|
  SolanaTimestamp.create(
    date: row['timestamp'],
    price: row['high']
  )
end


mahmoud = User.new({ email: 'mahmoud@gmail.com', password: '123456', first_name: "Mahmoud", last_name: "Hajji" })
spiros = User.new({ email: 'spiros12@gmail.com', password: '123456', first_name: "Spiros", last_name: "Tsiakalos" })
raisa = User.new({ email: 'raise@gmail.com', password: '123456', first_name: "Raisa", last_name: "Tarase" })
alex = User.new({ email: 'alex@gmail.com', password: '123456', first_name: "Alexandra", last_name: "Hedman" })
spiros.save
mahmoud.save
raisa.save
alex.save



# Collections:
# Gaming
okay_bears = Collection.create(name: 'Okay Bears', image: 'https://bafkreidgfsdjx4nt4vctch73hcchb3pkiwic2onfw5yr4756adchogk5de.ipfs.dweb.link/', description: 'A cool nft collection.', symbol: "OB", supply: 10000, listings: 984, floor_price: 14, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 1245532)

Collection.create(name: 'Okay Bears', image: 'https://bafkreidgfsdjx4nt4vctch73hcchb3pkiwic2onfw5yr4756adchogk5de.ipfs.dweb.link/', description: 'A cool nft collection.', symbol: "OB", supply: 10000, listings: 984, floor_price: 140, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 1245532)
Collection.create(name: 'na Monkey Business', description: 'A cool nft collection.', symbol: 'SMB', supply: 5555, listings: 459, floor_price: 26, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 34234)
Collection.create(name: 'DeGods', description: 'A cool nft collection.', symbol: "DG", supply: 8888, listings: 200, floor_price: 340, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 4353456 )
Collection.create(name: 'DegenIslands', description: 'A cool nft collection.', symbol: "DI", supply: 10000, listings: 1035, floor_price: 20, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 468689)

# Sports
Collection.create(name: 'STEPN', description: 'A cool nft collection.', symbol: "SPN", supply: 4444, listings: 227, floor_price: 5, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 213412)
Collection.create(name: 'Runners', description: 'A cool nft collection.', symbol: 'RNRS', supply: 3333, listings: 614, floor_price: 17, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 1234 )
Collection.create(name: 'STEPNxNIKE', description: 'A cool nft collection.', symbol: "STENKE", supply: 6666, listings: 129, floor_price: 2.8, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 354363 )
Collection.create(name: 'RunDogs', description: 'A cool nft collection.', symbol: "RD", supply: 7777, listings: 657, floor_price: 4.4, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 4235 )

# Metaverse
Collection.create(name: 'Frods', description: 'A cool nft collection.', symbol: "SG", supply: 5555, listings: 543, floor_price: 54, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 675857)
Collection.create(name: 'CetsOnCreck', description: 'A cool nft collection.', symbol: 'COC', supply: 4422, listings: 672, floor_price: 68, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 5685)
Collection.create(name: 'Mous in da hous', description: 'A cool nft collection.', symbol: "MIDH", supply: 3366, listings: 3097, floor_price: 1.5, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 8790787)
Collection.create(name: 'Duppies', description: 'A cool nft collection.', symbol: "DUPP", supply: 9999, listings: 230, floor_price: 20, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 13453464 )


# Music
Collection.create(name: 'Renegades', description: 'A cool nft collection.', symbol: "REN", supply: 11111, listings: 1003, floor_price: 18, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 123456)
Collection.create(name: 'Rock Bulls', description: 'A cool nft collection.', symbol: 'RB', supply: 10000, listings: 816, floor_price: 9.3, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 23455)
Collection.create(name: 'Music Raptors', description: 'A cool nft collection.', symbol: "MRAP", supply: 10000, listings: 78, floor_price: 20.7, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 45478)
Collection.create(name: 'The Amigos', description: 'A cool nft collection.', symbol: "TA", supply: 8585, listings: 0, floor_price: nil, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 0)

# Art
Collection.create(name: 'Moars', description: 'A cool nft collection.', symbol: "MRS", supply: 2222, listings: 200, floor_price: 12, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 2458 )
Collection.create(name: 'Ugly People', description: 'A cool nft collection.', symbol: 'UP', supply: 7575, listings: 488, floor_price: 6.5, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 84645)
Collection.create(name: 'Toxic Skulls Club', description: 'A cool nft collection.', symbol: "TSC", supply: 6969, listings: 398, floor_price: 90, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 98764)
Collection.create(name: 'The Lunartics', description: 'A cool nft collection.', symbol: "TLUNA", supply: 4646, listings: 0, floor_price: nil, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 0)

# Utility
Collection.create(name: 'Famous Fox Federation', description: 'A cool nft collection.', symbol: "FFF", supply: 4545, listings: 422,floor_price: 125, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 123467)
Collection.create(name: 'Stoned Frogs', description: 'A cool nft collection.', symbol: "SF", supply: 8787, listings: 521, floor_price: 15, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 323456)
Collection.create(name: 'Smoke Heads', description: 'A cool nft collection.', symbol: "SH", supply: 6767, listings: 569, floor_price: 15, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 3256)
Collection.create(name: 'X-Vault', description: 'A cool nft collection.', symbol: "XVLT", supply: 15000, listings: 0, floor_price: nil, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 0)

# Wallets:
Wallet.create(wallet_key: '12345678', user: alex)
Wallet.create(wallet_key: '23456789', user: mahmoud)
Wallet.create(wallet_key: '56789043', user: spiros)
Wallet.create(wallet_key: '23689045', user: raisa)


# NFTs:
Nft.create(mint_address: 'G4TU9HU6GjJdmBQzE2UYiraDC6JVVTAFEMSyT1cqrqZm', name: 'Okay Bear #9989',
  price: 40, image: 'https://bafybeidihp4ez5lw4sqqxu4kwcvhjc2qhm2szz7kkayyee425oamdfzrkm.ipfs.nftstorage.link/9988.png?ext=png',
  rarity: 'uncommon', purchase_date: Date.today, wallet: Wallet.first, collection: okay_bears)

Nft.create(mint_address: '8sPRUXUbNYqPGvfsrQJBJuA6CfGo3925Rhr6pa5XfB6r', name: 'Okay Bear #9972 ',
  price: 100, image: 'https://bafybeidihp4ez5lw4sqqxu4kwcvhjc2qhm2szz7kkayyee425oamdfzrkm.ipfs.nftstorage.link/9988.png?ext=png',
  rarity: 'rare', purchase_date: Date.today, wallet: Wallet.first, collection: okay_bears)

Nft.create(mint_address: '6PKU5dbY3c9eDnXkkwutM8Cm9DmiA1vMTnG891mn4aai', name: 'Okay Bear #9999',
  price: 80, image: 'https://bafybeib7iyh7l5jdqbl22jzx35xnvjjl2b2rcumqgtpnfxub7h3be3xrwq.ipfs.nftstorage.link/9998.png?ext=png',
  rarity: 'rare', purchase_date: Date.today, wallet: Wallet.first, collection: okay_bears)

Nft.create(mint_address: '4WD3rMDkMomGxNmLg4PRwd44eQKydDKsH7TA9YPeGRpQ', name: 'Okay Bear #9997',
  price: 80, image: 'https://bafybeib7iyh7l5jdqbl22jzx35xnvjjl2b2rcumqgtpnfxub7h3be3xrwq.ipfs.nftstorage.link/9996.png?ext=png',
  rarity: 'uncommon', purchase_date: Date.today, wallet: Wallet.first, collection: okay_bears)

Nft.create(mint_address: 'BKY3nztnk29ugvyMXtFyXVDvUp4uenUt9oBC6bMq97yA', name: 'Okay Bear #10000',
  price: 80, image: 'https://bafybeib7iyh7l5jdqbl22jzx35xnvjjl2b2rcumqgtpnfxub7h3be3xrwq.ipfs.nftstorage.link/9999.png?ext=png',
  rarity: 'uncommon', purchase_date: Date.today, wallet: Wallet.first, collection: okay_bears)

  Nft.create(name: 'Okay Bear', price: 17, image: 'https://bafybeifomfjtv4nkiddyv5lzl4l6nxjsmxkezhfkr2hlh5xamwnuyxozee.ipfs.dweb.link/5269.png?ext=png', rarity: 'Legendary', wallet: '12345678', collection_id: '1', purchase_date: '12.04.2022')
