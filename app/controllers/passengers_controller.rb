class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])
    head :not_found if !@passenger
    # raise
  end

  def new
    @passenger = Passenger.new
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
    head :not_found if !@passenger
  end

  def update
    this_passenger = Passenger.find_by(id: params[:id])

    is_successful = this_passenger.update(passenger_params)

    if is_successful
      redirect_to passenger_path
    else
      render :edit, status: :bad_request
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

  def destroy
    this_passenger = Passenger.find_by(id: params[:id])
    if this_passenger.nil?
      head :not_found
    else
      this_passenger.destroy
      redirect_to passengers_path
    end
  end

  private

  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
  end
end
