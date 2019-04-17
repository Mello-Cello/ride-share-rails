class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]
    @drivers = Driver.find_by(id: driver_id)
  end

  def new
    @drivers = Driver.new
  end
end
