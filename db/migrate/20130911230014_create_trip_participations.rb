class CreateTripParticipations < ActiveRecord::Migration
  def change
    create_table :trip_participations do |t|
      t.belongs_to :user
      t.belongs_to :trip
      t.boolean :primary

      t.timestamps
    end
  end
end
