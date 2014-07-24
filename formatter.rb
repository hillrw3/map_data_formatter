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
  end


  def yelp_query
    params = { category_filter: 'bars'}
    response = @client.search('Denver', params)
    json_response = response.to_json
    data = JSON.parse(json_response)
    businesses = data["businesses"]
    businesses
  end

end

@yelp_table = YelpTable.new(
  GschoolDatabaseConnection::DatabaseConnection.establish("development")
)

#Gathering data from Yelp & putting into DB
DataFormatter.new
data_formatter = DataFormatter.new
yelp_data = data_formatter.yelp_query


def geocode_address (address)
  results = Geocoder.search(address).to_json
  JSON.parse(results)[0]["data"]["geometry"]["location"]
end


yelp_data.each do |business|
  address = business["location"]["display_address"][0] + " " + business["location"]["postal_code"]
  if @yelp_table.find_id_by_name(business["name"].gsub(/'/, '')) == nil
    @yelp_table.create(business["name"].gsub(/'/, ''),
                         business["phone"],
                         address,
                         geocode_address(address)["lat"],
                         geocode_address(address)["lng"]
    )
    sleep(0.11)   #Google geocoding api has limit of 10/sec SUCK IT GOOGLE!
  end
end


