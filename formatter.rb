require "active_record"
require "gschool_database_connection"
require "yelp"
require "faraday"
require "geocoder"
require "json"

class DataFormatter

  def initialize
    super
    @client = Yelp::Client.new(:consumer_key    => '2C6rgKhf0AD8oMvkSxkeMA',
                               :consumer_secret => 'd_G_9y--T3Zo3xZBmCHsBAxlHvU',
                               :token           => 'twcpJoSxXdafBrAXUwyJjQ-RWEOEgJcH',
                               :token_secret    => '0P4Q5MUWLRK85lGm0CneI5K01pg')
  end


end

# params = { term: 'bar',limit: 5,}             #example Yelp query
# response = @client.search('Denver', params)
# json_response = response.to_json
# data = JSON.parse(json_response)
# businesses = data["businesses"]