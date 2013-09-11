class CreateMountains < ActiveRecord::Migration
  def change
    create_table :mountains do |t|
      t.string :name, null: false
      t.integer :height, null: false
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false
      t.text :notes

      t.timestamps
    end
  end
end
