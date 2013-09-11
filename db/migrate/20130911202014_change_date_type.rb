class ChangeDateType < ActiveRecord::Migration
  def up 
    remove_column :trips, :date 
    add_column :trips, :date, :integer, null: false
  end

  def down
    remove_column :trips, :date
    add_column :trips, :date, :date, null: false 
  end
end
