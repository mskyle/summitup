class List < ActiveRecord::Base
  validates_presence_of :title

  has_many :mountains, through: :mountain_lists
end
