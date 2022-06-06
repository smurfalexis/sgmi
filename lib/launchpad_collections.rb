require "uri"
require "net/http"
require 'json'


def get_all_collections
  offset = 0
  limit = 500
  result = collection_by_offset
    while result.length == limit
      p result.length
      sleep 5
      puts "slept for 5 sec, calling api again"
      # save_collections(result)
      offset = offset + limit
      result = collection_by_offset
      p offset
      p limit
    end
  #  save_collections(result)
  end

  def collection_by_offset(offset, limit)
    url = URI("https://api-mainnet.magiceden.dev/v2/collections?offset=#{offset}&limit=#{limit}")
    http = Net::HTTP.new(url.hostname, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    response = http.request(request)
    result = JSON.parse(response.body)
    result.length
  end

  # def save_collections(result)
  #   result.each do |r|
  #     Collection.create(symbol: r['symbol'], name: r['name'], description: r['description'],
  #                       image: r['image'], twitter: r['twitter'], discord: r['discord'],
  #                       category: r['categories'].join)
  #   end
  # end


p collection_by_offset()
