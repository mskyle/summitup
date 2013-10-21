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

  def self.filter(filter_hash, user)
    query_start = "SELECT mountains.* FROM mountains "
    query = query_start

    if filter_hash.has_key?(:hiked)
      hike_query = "INNER JOIN trip_mountains ON mountains.id = trip_mountains.mountain_id " + 
        "INNER JOIN trips ON trip_mountains.trip_id = trips.id " +
        "INNER JOIN trip_participations ON trips.id = trip_participations.trip_id " +
        "WHERE trip_participations.user_id = #{user.id} "
      if filter_hash[:hiked] == :hiked
        query += hike_query
      elsif filter_hash[:hiked] == :unhiked
        query += " EXCEPT SELECT mountains.* FROM mountains " + hike_query
      end
      if filter_hash.has_key?(:list)
        query += " INTERSECT " + query_start
      end
    end
    if filter_hash.has_key?(:list)
      list_query = "INNER JOIN mountain_lists ON mountains.id = mountain_lists.mountain_id WHERE mountain_lists.list_id = #{filter_hash[:list]}"
      query += list_query
    end
    if filter_hash.has_key?(:height)
      height_query = "height < #{filter_hash[:height][:top]} AND height > #{filter_hash[:height][:floor]}"
      if query.include?("WHERE")
        query += " AND " + height_query
      else
        query += " WHERE " + height_query
      end
    end
    Mountain.find_by_sql(query)
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
