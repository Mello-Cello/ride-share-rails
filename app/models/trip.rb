# frozen_string_literal: true

class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
  validates :cost, presence: true
  validates :date, presence: true
end
