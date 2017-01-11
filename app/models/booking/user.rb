module Booking
  class User < ActiveRecord::Base
    has_one :reservation, dependent: :destroy
    has_many :service_type_reservations, through: :reservations, dependent: :destroy
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
  end
end
