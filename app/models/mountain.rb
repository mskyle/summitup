class Mountain < ActiveRecord::Base
  include Conversions
  has_many :mountain_lists

  has_many :lists, 
    through: :mountain_lists

  has_many :trip_mountains, 
    inverse_of: :mountain
  
  has_many :trips, 
    through: :trip_mountains

  has_many :users, 
    through: :trips

  validates_presence_of :name
  validates_numericality_of :height
  validates_inclusion_of :height, within: 0..22000
  validates_numericality_of :latitude
  validates_inclusion_of :latitude, within: -90..90
  validates_numericality_of :longitude
  validates_inclusion_of :longitude, within: -180..180

  mount_uploader :image, ImageUploader

  # example filter_hash: 
  filter_hash = {
    height: {
      top: nil,
      floor: nil
    },
    hiked: true,
    list: 1
  }

  def self.filter(filter_hash, user)
    query_start = "SELECT mountains.* FROM mountains"
    hike_query = "INNER JOIN trip_mountains ON mountains.id = trip_mountains.mountain_id 
    INNER JOIN trips ON trip_mountains.trip_id = trips.id 
    INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
    WHERE trip_participations.user_id = #{user.id}"
    if filter == :hiked
      self.find_by_sql("#{query_start} #{hike_query}")
    elsif filter == :unhiked
      self.find_by_sql("#{query_start} EXCEPT #{query_start} #{hike_query}")
    elsif filter.class == List
      self.find_by_sql("#{query_start} INNER JOIN mountain_lists ON mountains.id = mountain_lists.mountain_id 
        WHERE mountain_lists.list_id = #{filter.id}")
    elsif filter
    end
  end



  def height_in_feet
    in_feet(height)
  end
  
  def alphabetical_name
    if self.name[0..5] == "Mount " || self.name[0..5] == "North " || self.name[0..5] == "South "
      alpha_name = self.name[6..-1] + self.name[0..4]
    elsif self.name[0..3] == "The "
      alpha_name = self.name[4..-1] + self.name[0..2]
    else
      alpha_name = self.name
    end
    alpha_name
  end

end
