class MountainsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def new
    @mountain = Mountain.new
  end

  def edit
    @mountain = Mountain.find(params[:id])
  end

  def update
    @mountain = Mountain.find(params[:id])
    if @mountain.update(mountain_params)
      redirect_to @mountain, notice: "awesome! mountain has been updated"
    else
      render action: 'edit'
    end
  end

  def create
    @mountain = Mountain.new(mountain_params)
    if @mountain.save
      redirect_to @mountain, notice: "awesome! you've added a mountain."
    else
      render action: 'new'
    end
  end

  def show
    @mountain = Mountain.find(params[:id])
    if user_signed_in?
      @current_user_trips = get_user_mountain_trips(current_user, @mountain)
    end
  end

  def index
    if params[:q]
      query = "%#{params[:q].downcase}%"
    end
    @mountains = Mountain.find_by_sql(build_query)
    @lists = List.all    
    respond_to do |format|
      format.json { render json: @mountains }
      format.html
    end
  end

  private

  def mountain_params
    params.require(:mountain).permit(:name, :height, :latitude, :longitude, :image)
  end

  def sort_column
    Mountain.column_names.include?(params[:sort]) ? params[:sort] : "height"
  end

  def get_all_filters
    params[:filter].present? ? params[:filter].split(" ") : []
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def build_query
    filters = [user_mountain_filter, height_filter, list_filter].delete_if { |filter| not filter.present? }
    if filters.length > 0 
      filter = "WHERE " + filters.join(" INTERSECT ")
    else 
      filter = ""
    end
    order = "ORDER BY #{sort_column} #{sort_direction}"
    "SELECT * FROM mountains "+ filter + " " + order
  end

  def user_mountain_filter
    if get_all_filters.include? "hiked"
      hiked_sql
    elsif get_all_filters.include? "unhiked"
      unhiked_sql
    else
      ""
    end
  end

  def height_filter
    height_hash = {
      "four-k" => "height > 4000",
      "three-four-k" => "(height > 3000 AND height < 4000)",
      "below-three-k" => "height < 3000"
    }

    height_query_array = []

    get_all_filters.each do |filter|
      if height_hash.has_key? filter
        height_query_array << height_hash[filter]
      end
    end
    height_query_string = height_query_array.join(" OR ")
    "#{height_query_string}" if height_query_string.present?
  end

  def hiked_sql 
    return "SELECT mountains.* FROM mountains INNER JOIN trip_mountains ON mountains.id = trip_mountains.mountain_id 
    INNER JOIN trips ON trip_mountains.trip_id = trips.id 
    INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
    WHERE trip_participations.user_id = #{current_user.id}"
  end

  def unhiked_sql 
    return "SELECT mountains.* FROM mountains EXCEPT SELECT mountains.* FROM mountains 
    INNER JOIN trip_mountains ON mountains.id = trip_mountains.mountain_id 
    INNER JOIN trips ON trip_mountains.trip_id = trips.id
    INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
    WHERE trip_participations.user_id = #{current_user.id}"
  end

  def list_filter
    list_query_array = []
    get_all_filters.each do |list_id|
      if List.ids.include?(list_id)
        query_array << "SELECT mountains.* FROM mountains INNER JOIN mountain_lists ON mountains.id = mountain_lists.mountain_id 
        WHERE mountain_lists.list_id = #{list_id}"
      end
    end
    list_query_array.join(" OR ")
  end

  def get_user_mountain_trips(user, mountain)
    user_id = user.id
    mountain_id = mountain.id
    Trip.find_by_sql("SELECT * FROM trips 
      INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
      WHERE trip_participations.user_id = #{user_id} 
      INTERSECT SELECT trips.* FROM trips 
      INNER JOIN trip_mountains ON trips.id = trip_mountains.trip_id 
      WHERE trip_mountains.mountain_id = #{mountain_id}")
  end

end
