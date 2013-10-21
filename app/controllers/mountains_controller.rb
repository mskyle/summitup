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

end
