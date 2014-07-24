class YelpTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(name, phone, address)
    insert_location_sql = <<-SQL
      INSERT INTO yelp_data (name, phone, address)
      VALUES ('#{name}', '#{phone}', '#{address}')
      RETURNING id
    SQL

    @database_connection.sql(insert_location_sql).first["id"]
  end

end