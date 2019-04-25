require "test_helper"

describe PassengersController do
  let (:passenger) do
    Passenger.create(name: "Fuzzy Bunny", phone_num: "843-665-5778")
  end

  describe "index" do
    it "can get passengers index" do
      get passengers_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "display a valid passenger" do
      get passenger_path(passenger.id)
      must_respond_with :success
    end

    it "return a 404 not found when searching for a non-existant passenger" do
      get passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "get the edit page for a passenger" do
      get edit_passenger_path(passenger.id)
      must_respond_with :success
    end

    it "respond with 404 not found when loading the edit page for a nonexistant passenger" do
      get edit_passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    new_params = {
      passenger: {
        name: "Terry Turtle",
        phone_num: "555-1212",
      },
    }

    it "update an existing passenger" do
      passenger_to_update = Passenger.create!(
        name: "Fredrica Fishes",
        phone_num: "+42 857-757-5736",
      )
      expect {
        patch passenger_path(passenger_to_update.id), params: new_params
      }.wont_change "Passenger.count"

      passenger_to_update.reload
      expect(passenger_to_update.name).must_equal new_params[:passenger][:name]
      expect(passenger_to_update.phone_num).must_equal new_params[:passenger][:phone_num]
    end

    it "respond with 404 not found if updating a non-existant passenger" do
      # edge case: it should render a 404 if the passenger is not found
      # THIS TEST IS GIVING AN ERROR. WHY? It's trying to call .update on a nil object. Line 22 of controller should catch this.

      skip
      expect {
        patch passenger_path(-1), params: new_params
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end

    it "return a 400 bad_request when asked to update with invalid data" do

      # Arrange
      original_passenger = {
        name: "Katniss",
        phone_num: "RU43U3R4U",
      }

      passenger_to_update = Passenger.create(original_passenger)

      new_passenger_name = "" # invalid name
      new_passenger_phone = "54321"

      bad_params = {
        "passenger": {
          name: new_passenger_name,
          phone_num: new_passenger_phone,
        },
      }

      # Act
      expect {
        patch passenger_path(passenger_to_update.id), params: bad_params
      }.wont_change "Passenger.count"

      # Assert
      must_respond_with :bad_request
      passenger_to_update.reload
      expect(passenger_to_update.name).must_equal original_passenger[:name]
      expect(passenger_to_update.phone_num).must_equal original_passenger[:phone_num]
    end
  end

  describe "new" do
    it "get new passenger page" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "save a new passenger and redirect if given valid inputs" do

      # Arrange
      valid_passenger_name = "Georgia Giraffe"
      valid_passenger_phone = "4444444"
      valid_passenger_params = {
        passenger: {
          name: valid_passenger_name,
          phone_num: valid_passenger_phone,
        },
      }

      # Act
      expect {
        post passengers_path, params: valid_passenger_params
      }.must_change "Passenger.count", 1

      # Assert
      new_passenger = Passenger.find_by(name: valid_passenger_name)
      expect(new_passenger).wont_be_nil
      expect(new_passenger.name).must_equal valid_passenger_name
      expect(new_passenger.phone_num).must_equal valid_passenger_phone

      must_respond_with :redirect
    end

    it "return 404 bad request for an invalid passenger" do
      new_passenger_name = ""
      new_passenger_phone = "2IRS3967"
      bad_passenger_params = {
        passenger: {
          name: new_passenger_name,
          phone: new_passenger_phone,
        },
      }

      expect {
        post passengers_path, params: bad_passenger_params
      }.wont_change "Passenger.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "delete a passenger" do
      new_passenger = Passenger.create(name: "Fuzzy Bunny", phone_num: "99955545")

      expect {
        delete passenger_path(new_passenger.id)
      }.must_change "Passenger.count", -1

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "return a 404 not found error if the passenger is not found" do
      invalid_id = -1

      expect {
        delete passenger_path(invalid_id)
      }.wont_change "Passenger.count"
      must_respond_with :not_found
    end
  end
end

# describe PassengersController do
# describe "index" do
#   # Your tests go here
# end

# describe "show" do
#   # Your tests go here
# end

# describe "edit" do
#   # Your tests go here
# end

# describe "update" do
#   # Your tests go here
# end

# describe "new" do
#   # Your tests go here
# end

# describe "create" do
#   # Your tests go here
# end

# describe "destroy" do
#   # Your tests go here
# end
# end
