class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])
  end

  def new
    @trip = Trip.new
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
  end

  def destroy
    this_trip = Trip.find_by(id: params[:id])
    if this_trip.nil?
      head :not_found
    else
      this_trip.destroy
      redirect_to trips_path
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:date, :rating, :cost)
  end
end
