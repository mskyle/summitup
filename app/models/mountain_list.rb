class MountainList < ActiveRecord::Base
  validates_presence_of :mountain_id
  validates_numericality_of :mountain_id, only_integer: true

  validates_presence_of :list_id
  validates_numericality_of :list_id, only_integer: true

  belongs_to :list
  belongs_to :mountain 
end
