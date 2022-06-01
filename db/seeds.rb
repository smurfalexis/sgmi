# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

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



# Gaming
Collection.create(name: 'Okay Bears', description: 'A cool nft collection.', symbol: "OB", floor_price: 14, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 124553232)
Collection.create(name: 'na Monkey Business', description: 'A cool nft collection.', symbol: 'SMB', floor_price: 26, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 34234)
Collection.create(name: 'DeGods', description: 'A cool nft collection.', symbol: "DG", floor_price: 360, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 4353456 )
Collection.create(name: 'DegenIslands', description: 'A cool nft collection.', symbol: "DI", floor_price: 20, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 468689)

# Sports
Collection.create(name: 'STEPN', description: 'A cool nft collection.', symbol: "SPN", floor_price: 5, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 213412)
Collection.create(name: 'Runners', description: 'A cool nft collection.', symbol: 'RNRS', floor_price: 17, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 1234 )
Collection.create(name: 'STEPNxNIKE', description: 'A cool nft collection.', symbol: "STENKE", floor_price: 2.8, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 354363 )
Collection.create(name: 'RunDogs', description: 'A cool nft collection.', symbol: "RD", floor_price: 4.4, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 4235 )

# Metaverse
Collection.create(name: 'ods', description: 'A cool nft collection.', symbol: "SG", floor_price: 54, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 675857)
Collection.create(name: 'CetsOnCreck', description: 'A cool nft collection.', symbol: 'COC', floor_price: 68, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 5685)
Collection.create(name: 'Mous in da hous', description: 'A cool nft collection.', symbol: "MIDH", floor_price: 1.5, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 87907876)
Collection.create(name: 'Duppies', description: 'A cool nft collection.', symbol: "DUPP", floor_price: 20, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 13453464 )


# Music
Collection.create(name: 'Renegades', description: 'A cool nft collection.', symbol: "REN", floor_price: 18, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 123456)
Collection.create(name: 'Rock Bulls', description: 'A cool nft collection.', symbol: 'RB', floor_price: 9.3, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 23455)
Collection.create(name: 'Music Raptors', description: 'A cool nft collection.', symbol: "MRAP", floor_price: 20.7, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 45478)

# Art
Collection.create(name: 'Moars', description: 'A cool nft collection.', symbol: "MRS", floor_price: 12, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 2458 )
Collection.create(name: 'Ugly People', description: 'A cool nft collection.', symbol: 'UP', floor_price: 6.5, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 84645)
Collection.create(name: 'Toxic Skulls Club', description: 'A cool nft collection.', symbol: "TSC", floor_price: 90, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 98764)

# Utility
Collection.create(name: 'Famous Fox Federation', description: 'A cool nft collection.', symbol: "FFF", floor_price: 125, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 123467)
Collection.create(name: 'Stoned Frogs', description: 'A cool nft collection.', symbol: "SF", floor_price: 15, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 323456)
