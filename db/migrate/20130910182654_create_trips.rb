class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.date :date, :null => false
      t.string :title, :null => false
      t.text :note
      t.text :trails
      t.integer :book_time
      t.integer :actual_time
      t.decimal :distance
      t.integer :hike_difficulty
      t.integer :hike_awesomeness

      t.timestamps
    end
  end
end
