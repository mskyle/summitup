class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def index
    if user_signed_in?  
      @trips = current_user.trips.order(:date).page params[:page]
    else
      @trips = Trip.order(:date).page params[:page]
    end
  end

  def create
    trip_params[:user_ids] << current_user.id.to_s
    trip_params[:user_ids].uniq!
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to @trip, notice: "Awesome! Your hike has been recorded." 
    else
      render action: 'new'
    end
  end

  def show
    @trip = Trip.find(params[:id])  
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      redirect_to @trip, notice: "awesome! your hike has been updated"
    else
      render action: 'edit'
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:date, :title, :note, :trails, 
      :book_time, :actual_time, :distance, :hike_difficulty, 
      :hike_awesomeness, :chronic_date, :image, mountain_ids:[], user_ids:[])
  end

  def current_resource
    @current_resource ||= Trip.find(params[:id]) if params[:id]
  end

end
