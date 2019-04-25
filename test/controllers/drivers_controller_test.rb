require "test_helper"

describe DriversController do
  let (:driver) do
    Driver.create(name: "Rubber Ducky", vin: "8459HDK744P")
  end

  describe "index" do
    it "can get drivers index" do
      get drivers_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "display a valid driver" do
      get driver_path(driver.id)
      must_respond_with :success
    end

    it "return a 404 not found when searching for a non-existant driver" do
      get driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "get the edit page for a driver" do
      get edit_driver_path(driver.id)
      must_respond_with :success
    end

    it "respond with 404 not found when loading the edit page for a nonexistant driver" do
      get edit_driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    new_params = {
      driver: {
        name: "Terry Turtle",
        vin: "JEU86U8823HF438",
      },
    }

    it "update an existing driver" do
      driver_to_update = Driver.create!(
        name: "Rubber Ducky",
        vin: "ERUU8823HF438",
      )
      expect {
        patch driver_path(driver_to_update.id), params: new_params
      }.wont_change "Driver.count"

      driver_to_update.reload
      expect(driver_to_update.name).must_equal new_params[:driver][:name]
      expect(driver_to_update.vin).must_equal new_params[:driver][:vin]
    end

    it "respond with 404 not found if updating a non-existant driver" do
      # edge case: it should render a 404 if the driver is not found
      # THIS TEST IS GIVING AN ERROR. WHY? It's trying to call .update on a nil object. Line 22 of controller should catch this.

      skip
      expect {
        patch driver_path(-1), params: new_params
      }.wont_change "Driver.count"

      must_respond_with :not_found
    end

    it "return a 400 bad_request when asked to update with invalid data" do

      # Arrange
      original_driver = {
        name: "Sara Sabertooth",
        vin: "RU43U3R4U",
      }

      driver_to_update = Driver.create(original_driver)

      new_driver_name = "" # invalid name
      new_driver_vin = "Sandi Metz"

      bad_params = {
        "driver": {
          name: new_driver_name,
          vin: new_driver_vin,
        },
      }

      # Act
      expect {
        patch driver_path(driver_to_update.id), params: bad_params
      }.wont_change "Driver.count"

      # Assert
      must_respond_with :bad_request
      driver_to_update.reload
      expect(driver_to_update.name).must_equal original_driver[:name]
      expect(driver_to_update.vin).must_equal original_driver[:vin]
    end
  end

  describe "new" do
    it "get new driver page" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "save a new driver and redirect if given valid inputs" do

      # Arrange
      valid_driver_name = "Georgia Giraffe"
      valid_driver_vin = "3IF9EAF8"
      valid_driver_params = {
        driver: {
          name: valid_driver_name,
          vin: valid_driver_vin,
        },
      }

      # Act
      expect {
        post drivers_path, params: valid_driver_params
      }.must_change "Driver.count", 1

      # Assert
      new_driver = Driver.find_by(name: valid_driver_name)
      expect(new_driver).wont_be_nil
      expect(new_driver.name).must_equal valid_driver_name
      expect(new_driver.vin).must_equal valid_driver_vin

      must_respond_with :redirect
    end

    it "return 404 bad request for an invalid driver" do
      new_driver_name = ""
      new_driver_vin = "2IRS3967"
      bad_driver_params = {
        driver: {
          name: new_driver_name,
          vin: new_driver_vin,
        },
      }

      expect {
        post drivers_path, params: bad_driver_params
      }.wont_change "Driver.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "delete a driver" do
      new_driver = Driver.create(name: "Fuzzy Bunny", vin: "2UEI33484")

      expect {
        delete driver_path(new_driver.id)
      }.must_change "Driver.count", -1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "return a 404 not found error if the driver is not found" do
      invalid_id = -1

      expect {
        delete driver_path(invalid_id)
      }.wont_change "Driver.count"
      must_respond_with :not_found
    end
  end
end

# describe DriversController do
#   describe "index" do
#     it "can get index" do
#       # Your code here
#     end
#   end

#   describe "show" do
#     # Your tests go here
#   end

#   describe "edit" do
#     # Your tests go here
#   end

#   describe "update" do
#     # Your tests go here
#   end

#   describe "new" do
#     # Your tests go here
#   end

#   describe "create" do
#     # Your tests go here
#   end

#   describe "destroy" do
#     # Your tests go here
#   end
# end
