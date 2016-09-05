module Booking
  class Customer < ActiveRecord::Base
  	has_one :customer_reservation
  	has_one :reservation, through: :customer_reservation, dependent: :destroy
  end
end
