require "uri"
require "net/http"
require 'json'


def get_all_collections
offset = 0
limit = 500
result = collection_by_offset(offset, limit)
  while result.length == limit
    save_collections(result)
    offset = offset + limit
    result = collection_by_offset(offset, limit)
  end
  save_collections(result)
end

def collection_by_offset(offset, limit)
  url = URI("api-devnet.magiceden.dev/v2/collections?offset=#{offset}&limit=#{limit}")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  result = JSON.parse(response.body)
end

def save_collections(result)
  result.each do |collection|
    Collection.create(symbol: result['symbol'], name: result['name'], description: result['description']
                      image: result['image'], twitter: result['twitter'], discord: result['discord'],
                      categories: result['categories'].join)
  end
end
