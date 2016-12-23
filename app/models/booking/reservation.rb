module Booking
  class Reservation < ActiveRecord::Base
  	has_many :service_type_reservations, dependent: :destroy
    accepts_nested_attributes_for :service_type_reservations, allow_destroy: true
  	has_many :service_types, through: :service_type_reservations, dependent: :destroy
    has_many :service_calendars, through: :service_types, dependent: :destroy

  	has_one :customer_reservation, dependent: :destroy
    accepts_nested_attributes_for :customer_reservation
  	has_one :customer, through: :customer_reservation

    has_one :user_reservation, dependent: :destroy
    accepts_nested_attributes_for :user_reservation
    has_one :user, through: :user_reservation

    #validate :end_date_after_start_date?

  	# def end_date_after_start_date?
  	# 	if self[:check_out] < self[:check_in]
  	# 		errors[:check_out] << "Must be after check in date"
  	# 		return false
  	# 	else
  	# 		return true
  	# 	end
  	# end
  end
end
