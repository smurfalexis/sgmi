# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require "uri"
require "net/http"
require 'json'




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

mahmoud = User.new({ email: 'mahmoud@gmail.com', password: '123456', first_name: 'Mahmoud', last_name: 'Hajji' })
spiros = User.new({ email: 'spiros12@gmail.com', password: '123456', first_name: 'Spiros', last_name: 'Tsiakalos' })
raisa = User.new({ email: 'raise@gmail.com', password: '123456', first_name: 'Raisa', last_name: 'Tarase' })
alex = User.new({ email: 'alex@gmail.com', password: '123456', first_name: 'Alexandra', last_name: 'Hedman' })
spiros.save
mahmoud.save
raisa.save
alex.save

# Wallets:
wallet1 = Wallet.create(wallet_key: '12345678', user: alex)
wallet2 = Wallet.create(wallet_key: '23456789', user: mahmoud)
wallet3 = Wallet.create(wallet_key: '56789043', user: spiros)
wallet4 = Wallet.create(wallet_key: '23689045', user: raisa)

def get_all_collections
  offset = 0
  limit = 500
  result = collection_by_offset(offset, limit)
    while result.length == limit
      sleep 5
      puts "sleeping for 5 , calling api again"
      save_collections(result)
      offset = offset + limit
      result = collection_by_offset(offset, limit)
      p offset
    end
    save_collections(result)
  end

  def collection_by_offset(offset, limit)
    url = URI("https://api-mainnet.magiceden.dev/v2/collections?offset=#{offset}&limit=#{limit}")
    http = Net::HTTP.new(url.hostname, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    response = http.request(request)
    result = JSON.parse(response.body)
  end

  def save_collections(result)
    result.each do |r|
      Collection.create(symbol: r['symbol'], name: r['name'], description: r['description'],
                        image: r['image'], twitter: r['twitter'], discord: r['discord'],
                        category: r['categories'])
    end
  end


get_all_collections()


okay = Collection.create(name: 'Okay Bears',
  image: 'https://bafkreidgfsdjx4nt4vctch73hcchb3pkiwic2onfw5yr4756adchogk5de.ipfs.dweb.link/', description: 'A cool nft collection.', symbol: 'OB', supply: 10000, listings: 984, floor_price: 140, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 1245532, volume24: 20)
smb = Collection.create(name: 'Solana Monkey Business', image: 'https://i.imgur.com/bMH6qNc.png',
 description: 'A cool nft collection.', symbol: 'SMB', supply: 5555, listings: 459, floor_price: 26, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 34234, volume24: 25)
degods = Collection.create(name: 'DeGods', image: 'https://i.imgur.com/fO3tI1t.png',
    description: 'A cool nft collection.', symbol: 'DG', supply: 8888, listings: 200, floor_price: 340, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 4353456, volume24: 2)
cets = Collection.create(name: 'CETS ON CRECK',
  image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/cats_on_crack_pfp_1644850873089.png', description: 'A cool nft collection.', symbol: 'COC', supply: 10000, listings: 1035, floor_price: 20, category: 'Gaming', website: '#', twitter: '#', discord: '#', volume: 468689, volume24: 1)

# Sports
stepn = Collection.create(name: 'STEPN',
   image: 'https://dl.airtable.com/.attachmentThumbnails/d5c12b4eb46e676d72569a2084345c94/6ef0628f', description: 'A cool nft collection.', symbol: 'STPN', supply: 4444, listings: 227, floor_price: 5, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 213412, volume24: 30)
cardboard = Collection.create(name: 'Cardboard Citizens',
       image: 'https://bafybeigmadq45sivgqhmzfgckf6leravmnflv7ybrdycpdzmknux5hw444.ipfs.dweb.link/', description: 'A cool nft collection.', symbol: 'CC', supply: 3333, listings: 614, floor_price: 17, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 1234, volume24: 50)
creamy = Collection.create(name: 'Creamy Friends',
    image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/creamy_friends_pfp_1650234862751.png', description: 'A cool nft collection.', symbol: 'CF', supply: 6666, listings: 129, floor_price: 2.8, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 354363, volume24: 19)
lava = Collection.create(name: 'LavaRunners',
  image: 'https://dl.airtable.com/.attachmentThumbnails/ed78d34f38a945fe5ec6d4f2cf7c122f/07ae15aa', description: 'A cool nft collection.', symbol: 'LRUN', supply: 7777, listings: 657, floor_price: 4.4, category: 'Sports', website: '#', twitter: '#', discord: '#', volume: 4235, volume24: 20)

# Metaverse
aurory = Collection.create(name: 'Aurory', image: 'https://arweave.net/XnmNKTJOthZ1PcqSspYLPTjFHGJRCe-lGrapzNM0VVQ',
    description: 'A cool nft collection.', symbol: 'ARY', supply: 5555, listings: 543, floor_price: 54, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 675_857, volume24: 22)
moonly = Collection.create(name: 'Moonly',
    image: 'https://bafybeiek4gm4d5zsbgpaqjfd6xo5rfasdituixl4j4mx4b2yqqpvr2v3fu.ipfs.dweb.link/', description: 'A cool nft collection.', symbol: 'MNLY', supply: 4422, listings: 672, floor_price: 68, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 5685, volume24: 23)
mous = Collection.create(name: 'Mous in da hous',
  image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/midh_pfp_1650739885263.png', description: 'A cool nft collection.', symbol: 'MIDH', supply: 3366, listings: 3097, floor_price: 1.5, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 2790787, volume24: 21)
block = Collection.create(name: 'Blocksmith Labs',
   image: 'https://dl.airtable.com/.attachmentThumbnails/b1aabaad68ef1a7512de6a0ddd15f38d/47c53a89', description: 'A cool nft collection.', symbol: 'BL', supply: 9999, listings: 230, floor_price: 20, category: 'Metaverse', website: '#', twitter: '#', discord: '#', volume: 13453464, volume24: 20)

# Music
trippin = Collection.create(name: 'Trippin Ape Tribe', image: 'https://i.imgur.com/iFgvQva.png',
     description: 'A cool nft collection.', symbol: 'TAT', supply: 11111, listings: 1003, floor_price: 18, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 623456, volume24: 20)
gemmy = Collection.create(name: 'Gemmy',
   image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/gemmy_pfp_1651420536407.png', description: 'A cool nft collection.', symbol: 'GMY', supply: 10000, listings: 816, floor_price: 9.3, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 23455, volume24: 15)
ths = Collection.create(name: 'Tombstoned High Society',
 image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/tombstoned_pfp_1645169267186.gif', description: 'A cool nft collection.', symbol: 'THS', supply: 10000, listings: 78, floor_price: 20.7, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 45478, volume24: 26)
jelly = Collection.create(name: 'Jelly Rascals',
   image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/rascals_pfp_1653133332626.png', description: 'A cool nft collection.', symbol: 'JR', supply: 8585, listings: 0, floor_price: nil, category: 'Music', website: '#', twitter: '#', discord: '#', volume: 0, volume24: 0)

# Art
bothead = Collection.create(name: 'Bot Head',
     image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/bothead_pfp_1650926539002.gif', description: 'A cool nft collection.', symbol: 'BH', supply: 2222, listings: 200, floor_price: 12, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 2458, volume24: 3)
atadian = Collection.create(name: 'OG Atadians',
     image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/atadians_pfp_1646721263627.gif', description: 'A cool nft collection.', symbol: 'OGA', supply: 7575, listings: 488, floor_price: 6.5, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 84645, volume24: 5)
ssc = Collection.create(name: 'Smart Sea Society',
 image: 'https://bafybeicmmomyark7um7wfxhxxjpbg3vl6htx6qudmfq4b2iw5pixcb6uxe.ipfs.dweb.link/', description: 'A cool nft collection.', symbol: 'SSS', supply: 6969, listings: 0, floor_price: nil, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 0, volume24: 0)
bohemia = Collection.create(name: 'Bohemia',
     image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/bohemia_pfp_1645251493690.gif', description: 'A cool nft collection.', symbol: 'BHM', supply: 4646, listings: 0, floor_price: nil, category: 'Art', website: '#', twitter: '#', discord: '#', volume: 0, volume24: 0)

# Utility
fff = Collection.create(name: 'Famous Fox Federation',
 image: 'https://bafybeiglipep6klutky4atw7jhf7lknpgzbfqlmqmamqh5s6lwih6uopma.ipfs.dweb.link/', description: 'A cool nft collection.', symbol: 'FFF', supply: 4545, listings: 422, floor_price: 125, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 123467, volume24: 4)
tsf = Collection.create(name: 'The Stoned Frogs',
 image: 'https://bafybeig36sok3pfoxsms6x6wfaizt6m2qtqmmxpun4au3kvdypz6pxqdem.ipfs.dweb.link/', description: 'A cool nft collection.', symbol: 'TSF', supply: 8787, listings: 521, floor_price: 15, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 323456, volume24: 17)
smokeheads = Collection.create(name: 'Smoke Heads',
        image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/smokeheads_pfp_1652898735936.png', description: 'A cool nft collection.', symbol: 'SH', supply: 6767, listings: 569, floor_price: 15, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 3256, volume24: 10)
vault = Collection.create(name: 'The X-Vault DAO',
   image: 'https://creator-hub-prod.s3.us-east-2.amazonaws.com/the_vaultx_dao_pfp_1650030637531.gif', description: 'A cool nft collection.', symbol: 'XVLT', supply: 15000, listings: 0, floor_price: nil, category: 'Utility', website: '#', twitter: '#', discord: '#', volume: 0, volume24: 0)

# NFTs:
Nft.create(name: 'Okay Bear #2345', price: 17,
image: 'https://bafybeifomfjtv4nkiddyv5lzl4l6nxjsmxkezhfkr2hlh5xamwnuyxozee.ipfs.dweb.link/5269.png?ext=png', rarity: 'Legendary', wallet: wallet1, collection: okay, purchase_date: '12.04.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d49371')

Nft.create(name: 'DeGod #88', price: 28, image: 'https://metadata.degods.com/g/2209.png', rarity: 'Mythic',
wallet: wallet2, collection: degods, purchase_date: '15.03.2022', mint_address: 'xsfsndjfgagdfcdfdgfdgk87hecs4')
Nft.create(name: 'STEPN #3332', price: 1,
image: 'https://img-cdn.magiceden.dev/rs:fill:640:640:0:0/plain/https://arweave.net/BToZC2BgKOGNiZd1t15j9ZaHNMku8PYtw-3Y0I71UjI', rarity: 'Common', wallet: wallet1, collection: stepn, purchase_date: '10.12.2021', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d95678')
Nft.create(name: 'Cardboard Citizen #4', price: 2,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://bafybeidvsm7s3gccpnjsq6vmxzfegrxf67dk34ezgq45nc5wjej32v7wky.ipfs.dweb.link/2085.png', rarity: 'Epic', wallet: wallet2, collection: cardboard, purchase_date: '01.04.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d12356')
Nft.create(name: 'Creamy Friend #398', price: 4,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://www.arweave.net/mDnGUZP_R3g0Uo15lCrdhujqC6ItmltAkrWgMog8yrE?ext=png', rarity: 'Epic', wallet: wallet1, collection: creamy, purchase_date: '08.04.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d34589')
Nft.create(name: 'LavaRunner #222', price: 44,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://arweave.net/bsjdWnlDtFxoSeRVZ2OC2Msjkn5l1LDA1G26lRKiXig', rarity: 'Common', wallet: wallet1, collection: lava, purchase_date: '14.02.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d49345')
Nft.create(name: 'Blocksmith #900', price: 13,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://bafybeibyio7mu3hrughzxdryz45prwhgt5s5l64qp5f6n67664quuo226m.ipfs.dweb.link/2400.png?ext=png', rarity: 'Rare', wallet: wallet3, collection: block, purchase_date: '12.05.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d59071')
Nft.create(name: 'Mous #3245', price: 6,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://arweave.net/G3dTlVEeUJHJ3ToTwzOqkA3EgAG3p5z3pFrfnkNGV7A?ext=png', rarity: 'Legendary', wallet: wallet3, collection: mous, purchase_date: '24.05.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d23308')
Nft.create(name: 'Moonly #455', price: 3,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://bafybeigvliimk4m4yciqwebsrwbfmr4lsnlme7iphfbxezwstr67lzimpi.ipfs.dweb.link/3466.png?ext=png', rarity: 'Mythic', wallet: wallet3, collection: moonly, purchase_date: '09.01.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d35678')
Nft.create(name: 'Tripin Ape #2355', price: 4,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://bafybeiblifubtp4rzgkxs4uklisn3en6yulhmrnm4zj7rmvtnql2nibfle.ipfs.dweb.link/1363.png?ext=png', rarity: 'Uncommon', wallet: wallet4, collection: trippin, purchase_date: '16.01.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d77890')
Nft.create(name: 'THS #344', price: 75,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://arweave.net/m0_NyfxvB-5WUlVZS5J3V9uDu7ayHnABgypmUvL-XK0', rarity: 'Epic', wallet: wallet4, collection: ths, purchase_date: '13.03.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d44356')
Nft.create(name: 'Bohemia #55', price: 32,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://arweave.net/E-DgJY_vT76C7vwmFboXa0q0QF7JUygIlpaV0rraaDg?ext=png', rarity: 'Rare', wallet: wallet4, collection: bohemia, purchase_date: '04.04.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d88911')
Nft.create(name: 'Smoke Head #666', price: 27,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://bafybeiepvcjfm5kppole3ugyrkinfcd4m2efjpdjnlqh3julkadnttqbxi.ipfs.dweb.link/3743.png', rarity: 'Legendary', wallet: wallet2, collection: smokeheads, purchase_date: '13.05.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d01543')
Nft.create(name: 'TSF #567', price: 19,
image: 'https://img-cdn.magiceden.dev/rs:fill:400:400:0:0/plain/https://bafybeibnib5qhvcovaxq7ow5p4wgj3aav6nf747woszxxhlsjqgvrsbjna.ipfs.dweb.link/6263.png?ext=png', rarity: 'Legendary', wallet: wallet4, collection: tsf, purchase_date: '22.02.2022', mint_address: '0x0Fd433e474ECB81005ac906e0BCFab66E1d49381')
