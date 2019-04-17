class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id]
    @trips = Trip.find_by(id: trip_id)
  end

  def new
    @trips = Trip.new
  end
end
