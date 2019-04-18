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

  def edit
    @passenger = Passenger.find_by(id: params[:id])
  end

  def update
    this_passenger = Passenger.find_by(id: params[:id])

    is_successful = this_passenger.update(passenger_params)

    if is_successful
      redirect_to passenger_path
    else
      redirect_to passenger_path
    end
  end

  def create
    @passenger = Passenger.new(passenger_params)

    is_successful = @passenger.save

    if is_successful
      redirect_to passenger_path(@passenger.id)
    else
      render :new, status: :bad_request
    end
  end

  private

  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
  end
end
