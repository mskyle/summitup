class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: "Awesome! Your hike has been recorded." }
        format.json { render action: 'show', status: :created, location: @trip }
      else
        format.html { render action: 'new' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def trip_params
    params.require(:trip).permit(:date, :title, :note, :trails, :book_time, :actual_time, :distance, :hike_difficulty, :hike_awesomeness)
  end

end