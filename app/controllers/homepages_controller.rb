# frozen_string_literal: true

class HomepagesController < ApplicationController
  def index
    @trips = Trip.all
  end
end
