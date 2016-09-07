module Booking
  class ServiceType < ActiveRecord::Base
  	has_many :service_type_reservations, dependent: :destroy
  	has_many :reservations, through: :service_type_reservations, dependent: :destroy
  	has_many :blocked_days, dependent: :destroy
  	accepts_nested_attributes_for :blocked_days, allow_destroy: true

  	validates :name, :length => {:minimum => 1}
  	validates_presence_of :default_price
  end
end
