class MountainList < ActiveRecord::Base
  validates_presence_of :mountain_id
  validates_presence_of :list_id

  belongs_to :list
  belongs_to :mountain 
end
