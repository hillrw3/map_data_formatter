class YelpTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(name, phone, street_address, city_state)
    insert_location_sql = <<-SQL
      INSERT INTO yelp_data (name, phone, street_address, city_state)
      VALUES ('#{name}', '#{phone}', '#{street_address}', #{city_state})
      RETURNING id
    SQL

    @database_connection.sql(insert_location_sql).first["id"]
  end

end