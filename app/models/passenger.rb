class Passenger < ApplicationRecord
  has_many :trip
  validates :name, presence: true
  validates :phone_num, presence: true
end
