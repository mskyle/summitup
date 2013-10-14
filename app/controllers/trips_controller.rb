class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def index
    @trips = Trip.order(:date).page params[:page]
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to @trip, notice: "Awesome! Your hike has been recorded." }
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

  private

  def trip_params
    params.require(:trip).permit(:date, :title, :note, :trails, 
      :book_time, :actual_time, :distance, :hike_difficulty, 
      :hike_awesomeness, :chronic_date, mountain_ids:[], user_ids:[])
  end

end
