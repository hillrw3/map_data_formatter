class YelpTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(name, phone, address, latitude, longitude)
    insert_location_sql = <<-SQL
      INSERT INTO yelp_data (name, phone, address, latitude, longitude)
      VALUES ('#{name}', '#{phone}', '#{address}', #{latitude}, #{longitude})
      RETURNING id
    SQL

    @database_connection.sql(insert_location_sql).first["id"]
  end

  def select_all
    @database_connection.sql("select * from yelp_data")
  end

  def address
    @database_connection.sql("select address from yelp_data")
  end

  def find_id_by_name(name)
    find_sql = <<-SQL
      SELECT * FROM yelp_data
      WHERE name = '#{name}'
    SQL

    @database_connection.sql(find_sql).first
  end

end