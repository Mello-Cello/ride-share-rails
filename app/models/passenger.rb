class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_spent
    sum = 0
    self.trips.each do |trip|
      sum += trip.cost.to_f / 100
    end
    return sum
  end
end
