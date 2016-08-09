module Booking
  class Reservation < ActiveRecord::Base
  	has_many :service_type_reservations, dependent: :destroy
  	has_many :service_types, through: :service_type_reservations, dependent: :destroy
  	has_one :customer_reservation, dependent: :destroy
  	has_one :customer, through: :customer_reservation, dependent: :destroy

  	validates :service_types, :length => {:minimum => 1}
  	validate :end_date_after_start_date?

    accepts_nested_attributes_for :service_type_reservations

  	def end_date_after_start_date?
  		if self[:check_out] < self[:check_in]
  			errors[:check_out] << "Must be after check in date"
  			return false
  		else
  			return true
  		end
  	end
  end
end
