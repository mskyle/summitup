class List < ActiveRecord::Base
  validates_presence_of :title

  has_many :mountain_lists
  has_many :mountains, through: :mountain_lists
end
