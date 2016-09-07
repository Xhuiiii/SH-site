module Booking
  class ServiceType < ActiveRecord::Base
  	has_many :service_type_reservations, dependent: :destroy
  	has_many :reservations, through: :service_type_reservations, dependent: :destroy
  	has_many :blocked_days, dependent: :destroy

  	validates :name, :length => {:minimum => 1}
  	validates_presence_of :default_price
  end
end
