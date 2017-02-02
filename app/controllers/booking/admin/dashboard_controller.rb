require_dependency "booking/application_controller"

module Booking
  class Admin::DashboardController < ApplicationController
    #before_filter :authenticate_user!

    def index
    end
  end
end
