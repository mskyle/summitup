class CreateTripParticipations < ActiveRecord::Migration
  def change
    create_table :trip_participations do |t|
      t.belongs_to :user, null: false
      t.belongs_to :trip, null: false
      t.boolean :primary

      t.timestamps
    end
  end
end
