class CreateTripMountains < ActiveRecord::Migration
  def change
    create_table :trip_mountains do |t|
      t.belongs_to :mountain, null: false
      t.belongs_to :trip, null: false

      t.timestamps
    end
  end
end
