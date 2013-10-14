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
      @mountains = Mountain.order(sort_column + " " + sort_direction)
    end
    respond_to do |format|
      format.json { render json: @mountains }
      format.html
    end
    @lists = List.all
  end

  private

  def mountain_params
    params.require(:mountain).permit(:name, :height, :latitude, :longitude, :image)
  end

  def sort_column
    Mountain.column_names.include?(params[:sort]) ? params[:sort] : "height"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def user_mountain_filter
    (user_signed_in? && %w[hiked unhiked].include?(params[:filter])) ? params[:filter] : nil
  end

  def get_all_filters
    params[:filter].split(" ")
  end

  def height_filter
    %w[four-k three-four-k below-three-k].include(params[:filter]) ? params[:filter] : nil
  end

  def list_filter
    List.id.include?(params[:filter]) ? params[:filter] : nil
  end

  def get_user_mountain_trips(user, mountain)
    user_id = user.id
    mountain_id = mountain.id
    Trip.find_by_sql("SELECT trips.* FROM trips 
      INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
      WHERE trip_participations.user_id = #{user_id} 
      INTERSECT SELECT trips.* FROM trips 
      INNER JOIN trip_mountains ON trips.id = trip_mountains.trip_id 
      WHERE trip_mountains.mountain_id = #{mountain_id}")
  end

end
