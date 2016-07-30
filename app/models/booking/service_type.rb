module Booking
  class ServiceType < ActiveRecord::Base
  	has_and_belongs_to_many :reservations
  	has_many :customers, through: :reservations
  end
end
