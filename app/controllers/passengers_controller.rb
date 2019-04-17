class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
  end

  def new
    @passenger = Passenger.new
  end
end
