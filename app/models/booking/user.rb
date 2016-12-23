module Booking
  class User < ActiveRecord::Base
    has_one :user_reservation, dependent: :destroy
    has_one :reservation, through: :user_reservation, dependent: :destroy
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
  end
end
