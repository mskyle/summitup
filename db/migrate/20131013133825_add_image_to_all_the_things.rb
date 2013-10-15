class AddImageToAllTheThings < ActiveRecord::Migration
  def change
    add_column :mountains, :image, :string
    add_column :users, :image, :string
    add_column :trips, :image, :string
  end
end
