class AddLatLongToYelp < ActiveRecord::Migration
  def change
    add_column :yelp_data, :latitude, :float
    add_column :yelp_data, :longitude, :float
  end
end
