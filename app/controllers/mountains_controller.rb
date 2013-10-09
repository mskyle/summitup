class MountainsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def new
    @mountain = Mountain.new
  end

  def create
    @mountain = Mountain.new(mountain_params)

    respond_to do |format|
      if @mountain.save
        format.html { redirect_to @mountain, notice: "awesome! you've added a mountain." }
        format.json { render action: 'show', status: :created, location: @mountain }
      else
        format.html { render action: 'new' }
        format.json { render json: @mountain.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def index
    if params[:q]
      query = "%#{params[:q].downcase}%"
      @mountains = Mountain.where("lower(name) LIKE ? ", query).limit(10)
    else
      mountains = Mountain.all
      if user_signed_in?
        if user_mountain_filter == "hiked"
          mountains = current_user.mountains
          binding.pry
        elsif user_mountain_filter == "unhiked"
          mountains = Mountain.all - current_user.mountains
        end
      end
      @mountains = mountains.order(sort_column + " " + sort_direction) # Mountain.order(sort_column + " " + sort_direction)
    end
    respond_to do |format|
      format.json { render json: @mountains }
      format.html
    end
    @lists = List.all
  end

  private

  def mountain_params
    params.require(:mountain).permit(:name, :height, :latitude, :longitude)
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

end