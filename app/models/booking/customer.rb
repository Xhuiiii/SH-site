module Booking
  class Customer < ActiveRecord::Base
  	has_and_belongs_to_many :reservations
  	has_many :service_types, through: :reservations
  end
end
