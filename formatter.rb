require "active_record"
require "gschool_database_connection"
require "yelp"
require "faraday"
require "geocoder"
require "json"
require_relative "lib/yelp_table"

class DataFormatter

  def initialize
    super
    @client = Yelp::Client.new(:consumer_key    => '2C6rgKhf0AD8oMvkSxkeMA',
                               :consumer_secret => 'd_G_9y--T3Zo3xZBmCHsBAxlHvU',
                               :token           => '87I0Rbf-mqU5469GuejO9BbNIIRKsm7z',
                               :token_secret    => 'mka5uunaiRgNo0x47oyF83qa4_Y')
    @yelp_table = YelpTable.new(
      GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
    )
  end


  def yelp_query
    params = { term: 'bar'}
    response = @client.search('Denver', params)
    json_response = response.to_json
    data = JSON.parse(json_response)
    businesses = data["businesses"]
  end

end

#Gathering data from Yelp & putting into DB
data_formatter = DataFormatter.new
yelp_data = data_formatter.yelp_query

yelp_data.each do |business|
  @yelp_table.create(business["name"],
                         business["phone"],
                         business["location"]["display_address"][0],    #Still need to make sql commands for yelp data
                         business["location"]["display_address"][1])
end


#Geocoding Yelp data
results = Geocoder.search("517 e. 12th ave Denver CO ").to_json
jj JSON.parse(results)[0]["data"]["geometry"]["location"]