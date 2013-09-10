class CreateMountains < ActiveRecord::Migration
  def change
    create_table :mountains do |t|
      t.string :name
      t.integer :height
      t.decimal :latitude
      t.decimal :longitude
      t.text :notes

      t.timestamps
    end
  end
end
