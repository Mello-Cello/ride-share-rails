class TripsController < ApplicationController
  def index
    # if params[:passenger_id]
    #   passenger = Passenger.find_by(id: params[:passenger_id])
    #   @trips = passenger.trips
    # else
    @trips = Trip.all
    # end
  end

  def show
    @trip = Trip.find_by(id: params[:id])
  end

  def new
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new
    elsif params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trip = driver.trips.new
    else
      @trip = Trip.new
    end
  end

  def create
    @trip = Trip.new(trip_params)
    is_successful = @trip.save

    if is_successful
      redirect_to trip_path(@trip.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
  end

  def update
    trip = Trip.find_by(id: params[:id])

    is_successful = trip.update(trip_params)

    if is_successful
      redirect_to trip_path(trip.id)
    else
      @trip = book
      render :edit, status: :bad_request
    end
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
    params.require(:trip).permit(:date, :rating, :cost, :passenger_id, :driver_id)
  end
end
