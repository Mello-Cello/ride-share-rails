class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])
  end

  def new
    @drivers = Driver.new
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
  end

  def update
    this_driver = Driver.find_by(id: params[:id])

    is_successful = this_driver.update(driver_params)

    if is_successful
      redirect_to driver_path
    else
      redirect_to driver_path
    end
  end

  def create
    @driver = Driver.new(driver_params)

    is_successful = @driver.save

    if is_successful
      redirect_to driver_path(@driver.id)
    else
      render :new, status: :bad_request
    end
  end

  def destroy
    this_driver = Driver.find_by(id: params[:id])
    if this_driver.nil?
      head :not_found
    else
      this_driver.destroy
      redirect_to drivers_path
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :vin)
  end
end
