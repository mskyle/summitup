class Mountain < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :height
  validates_inclusion_of :height, within: 0..22000
  validates_numericality_of :latitude
  validates_inclusion_of :latitude, within: -90..90
  validates_numericality_of :longitude
  validates_inclusion_of :longitude, within: -180..180

  #has_many :trip_mountains, inverse_of: :mountain

  #has_many :trips, through: :trip_mountains, inverse_of: :mountains
  has_many :mountain_lists

  has_many :lists, 
    through: :mountain_lists

  has_many :trip_mountains, 
    inverse_of: :mountain
  
  has_many :trips, 
    through: :trip_mountains

  has_many :users, 
    through: :trips

  # def name=(name)
  #   set_alpha_name(name)
  #   @name = name
  # end

  scope :hiked_by, -> (user) { where(self.users.include?(user)) }

def alphabetical_name
    if self.name[0..5] == "Mount " || self.name[0..5] == "North " || self.name[0..5] == "South"
      alpha_name = self.name[6..-1] + self.name[0..5]
    elsif self.name[0..3] == "The "
      alpha_name = self.name[4..-1] + self.name[0..3]
    else
      alpha_name = self.name
    end
    alpha_name
  end

  private
  # def set_alpha_name(name)

  # end
end
