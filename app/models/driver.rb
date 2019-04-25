# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true

  def total_earned
    sum = 0
    self.trips.each do |trip|
      sum += ((trip.cost.to_f / 100) - 1.65) * 0.8
    end
    return sum
  end

  def avg_rating
    ratings_total = 0
    i = 0
    self.trips.each do |trip|
      if trip.rating
        ratings_total += trip.rating.to_f
      end
      i += 1
    end

    if i > 0
      avg_rating = ratings_total / i
      return avg_rating.round(2)
    else
      return 0
    end
  end
end
