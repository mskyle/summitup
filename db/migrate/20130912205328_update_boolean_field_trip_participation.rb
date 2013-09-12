class UpdateBooleanFieldTripParticipation < ActiveRecord::Migration
  def up
    change_column :trip_participations, :primary, :boolean, default: true
  end

  def down
    change_column :trip_participations, :primary, :boolean
  end
end
