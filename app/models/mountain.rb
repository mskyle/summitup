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

  def self.get_mountains(filter_array, user, sort_column, sort_direction)
    filter_hash = self.generate_filter_hash(filter_array)
    self.filter(filter_hash, user, sort_column, sort_direction)
  end

  def self.filter(filter_hash, user = nil, sort_column = "height", sort_direction = "desc")
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
    query += " ORDER BY #{sort_column} #{sort_direction}"
    Mountain.find_by_sql(query)
  end

  def self.generate_filter_hash(filter_array)
    filter_hash = { height: { top: 22000, floor: 0} }
    if filter_array.include?("hiked") 
      filter_hash[:hiked] = :hiked
    end
    if filter_array.include?("unhiked")
      filter_hash[:hiked] = :unhiked
      if filter_array.include?("hiked")
        filter_hash[:hiked] = nil 
      end
    end
    if filter_array.include?("four-k")
      filter_hash[:height][:floor] = 1219
    end
    if filter_array.include?("three-four-k")
      filter_hash[:height][:floor] = 914
    end
    if filter_array.include?("three-k")
      filter_hash[:height][:top] = 914
    end
    if filter_array.include?("three-four-k")
      filter_hash[:height][:top] = 1219
    end
    if filter_array.include?("four-k")
      filter_hash[:height][:top] = 22000
    end
    filter_array.each { |filter| filter_hash[:list] = filter if filter.to_i.to_s == filter }
    filter_hash
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

  def get_user_mountain_trips(user)
    user_id = user.id
    mountain_id = self.id
    Trip.find_by_sql("SELECT trips.* FROM trips 
      INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
      WHERE trip_participations.user_id = #{user_id} 
      INTERSECT SELECT trips.* FROM trips 
      INNER JOIN trip_mountains ON trips.id = trip_mountains.trip_id 
      WHERE trip_mountains.mountain_id = #{mountain_id}")
  end

end
