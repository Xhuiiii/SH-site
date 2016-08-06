module Booking
  class Customer < ActiveRecord::Base
  	has_many :customer_reservations
  	has_many :reservations, through: :customer_reservations, dependent: :destroy
  end
end
