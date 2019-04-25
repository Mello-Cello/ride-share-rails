require "test_helper"
require "pry"

describe TripsController do
  let (:passenger) do
    Passenger.create(name: "Fuzzy Bunny", phone_num: "843-665-5778")
  end

  let (:driver) do
    Driver.create(name: "Rubber Ducky", vin: "8459HDK744P")
  end

  let (:trip) do
    Trip.create(date: "2019-05-05", rating: 4, cost: 1452, passenger_id: passenger.id, driver_id: driver.id)
  end

  describe "index" do
    it "can get trip index" do
      get trips_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "display a valid trip" do
      get trip_path(trip.id)
      must_respond_with :success
    end

    it "return a 404 not found when searching for a non-existant trip" do
      get trip_path(-1)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "get the edit page for a trip" do
      get edit_trip_path(trip.id)
      must_respond_with :success
    end

    it "respond with 404 not found when loading the edit page for a nonexistant trip" do
      get edit_trip_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    #   skip
    # Having trouble with writing this test.
    it "update an existing trip" do
      existing_trip = trip
      new_params = {
        trip: {
          date: "2019-11-15".to_date,
          rating: 2,
          cost: 1111,
          passenger_id: existing_trip.passenger_id,
          driver_id: existing_trip.driver_id,
        },
      }

      # trip_to_update = Trip.create!(new_params[:trip])
      # # binding.pry
      expect {
        patch trip_path(existing_trip.id), params: new_params
      }.wont_change "Trip.count"
      existing_trip.reload
      expect(existing_trip.cost).must_equal new_params[:trip][:cost]
      expect(existing_trip.rating).must_equal new_params[:trip][:rating]
    end
  end

  it "return a 400 bad_request when asked to update a trip with invalid data" do
    existing_trip = trip
    bad_params = {
      trip: {
        date: "",
        rating: 2,
        cost: 1111,
        passenger_id: existing_trip.passenger_id,
        driver_id: existing_trip.driver_id,
      },
    }

    # trip_to_update = Trip.create!(new_params[:trip])
    # # binding.pry
    expect {
      patch trip_path(existing_trip.id), params: bad_params
    }.wont_change "Trip.count"
    must_respond_with :bad_request

    existing_trip.reload
    expect(existing_trip.cost).must_equal trip[:cost]
  end

  describe "new" do
    it "get new trip page" do
      get new_trip_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "save a new trip and redirect if given valid inputs" do

      # Arrange

      driver1 = Driver.create!(
        name: "Rubber Ducky",
        vin: "ERUU8823HF438",
      )

      passenger1 = Passenger.create!(
        name: "Fredrica Fishes",
        phone_num: "+42 857-757-5736",
      )
      valid_trip_params = {
        trip: {
          driver_id: driver1.id, passenger_id: passenger1.id, date: "2019-12-11".to_date, cost: 9875, rating: 5,
        },
      }

      # Act
      expect {
        post trips_path, params: valid_trip_params
      }.must_change "Trip.count", 1

      # Assert
      must_respond_with :redirect
    end

    it "return 404 bad request for an invalid trip" do
      driver1 = Driver.create!(
        name: "Rubber Ducky",
        vin: "ERUU8823HF438",
      )

      passenger1 = Passenger.create!(
        name: "Fredrica Fishes",
        phone_num: "+42 857-757-5736",
      )
      bad_trip_params = {
        trip: {
          driver_id: driver1.id, passenger_id: passenger1.id, date: "2019-12-11".to_date, rating: 5,
        },
      }

      expect {
        post trips_path, params: bad_trip_params
      }.wont_change "Trip.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "delete a trip" do
      this_trip = trip
      expect {
        delete trip_path(this_trip.id)
      }.must_change "Trip.count", -1

      must_respond_with :redirect
      must_redirect_to trips_path
    end

    it "return a 404 not found error if the trip is not found" do
      invalid_id = -1

      expect {
        delete trip_path(invalid_id)
      }.wont_change "Trip.count"
      must_respond_with :not_found
    end
  end
end
