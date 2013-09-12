class CreateMountainLists < ActiveRecord::Migration
  def change
    create_table :mountain_lists do |t|
      t.belongs_to :mountain, null: false
      t.belongs_to :list, null: false

      t.timestamps
    end
  end
end
