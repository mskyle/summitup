class MountainList < ActiveRecord::Base
  validates_presence_of :mountain
  validates_presence_of :list
  belongs_to :list
  belongs_to :mountain 
end
