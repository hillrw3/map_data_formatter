class YelpData < ActiveRecord::Migration
  def up
    create_table :yelp_data do |t|
      t.string :name
      t.string :phone
      t.string :address
    end
  end

  def down
    # add reverse migration code here
  end
end
