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
Collection.create(name: 'Okay Bears', description: 'A cool nft collection.', symbol: "OB", floor_price: '50SOL', category: 'Gaming', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Solana Monkey Business', description: 'A cool nft collection.', symbol: 'SMB', floor_price: '60SOL', category: 'Gaming', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'DeGods', description: 'A cool nft collection.', symbol: "DG", floor_price: '60SOL', category: 'Gaming', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'DegenIslands', description: 'A cool nft collection.', symbol: "DI", floor_price: '20SOL', category: 'Gaming', website: '#', twitter: '#', discord: '#')

# Sports
Collection.create(name: 'STEPN', description: 'A cool nft collection.', symbol: "SPN", floor_price: '50SOL', category: 'Sports', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Runners', description: 'A cool nft collection.', symbol: 'RNRS', floor_price: '60SOL', category: 'Sports', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'STEPNxNIKE', description: 'A cool nft collection.', symbol: "STENKE", floor_price: '60SOL', category: 'Sports', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'RunDogs', description: 'A cool nft collection.', symbol: "RD", floor_price: '20SOL', category: 'Sports', website: '#', twitter: '#', discord: '#')

# Metaverse
Collection.create(name: 'SolGods', description: 'A cool nft collection.', symbol: "SG", floor_price: '50SOL', category: 'Metaverse', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'CetsOnCreck', description: 'A cool nft collection.', symbol: 'COC', floor_price: '60SOL', category: 'Metaverse', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Mous in da hous', description: 'A cool nft collection.', symbol: "MIDH", floor_price: '60SOL', category: 'Metaverse', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Duppies', description: 'A cool nft collection.', symbol: "DUPP", floor_price: '20SOL', category: 'Metaverse', website: '#', twitter: '#', discord: '#')


# Music
Collection.create(name: 'Renegades', description: 'A cool nft collection.', symbol: "REN", floor_price: '50SOL', category: 'Music', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Rock Bulls', description: 'A cool nft collection.', symbol: 'RB', floor_price: '60SOL', category: 'Music', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Music Raptors', description: 'A cool nft collection.', symbol: "MRAP", floor_price: '60SOL', category: 'Music', website: '#', twitter: '#', discord: '#')

# Art
Collection.create(name: 'Moars', description: 'A cool nft collection.', symbol: "MRS", floor_price: '50SOL', category: 'Art', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Ugly People', description: 'A cool nft collection.', symbol: 'UP', floor_price: '60SOL', category: 'Art', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Toxic Skulls Club', description: 'A cool nft collection.', symbol: "TSC", floor_price: '60SOL', category: 'Art', website: '#', twitter: '#', discord: '#')

# Utility
Collection.create(name: 'Famous Fox Federation', description: 'A cool nft collection.', symbol: "FFF", floor_price: '50SOL', category: 'Utility', website: '#', twitter: '#', discord: '#')
Collection.create(name: 'Stoned Frogs', description: 'A cool nft collection.', symbol: "SF", floor_price: '15SOL', category: 'Utility', website: '#', twitter: '#', discord: '#')