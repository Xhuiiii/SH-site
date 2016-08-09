#Provides any common functionality for the controllers of the engine
#Where other controllers for the booking engine will go
# Add 'require_dependency "booking/application_controller"' to other controllers to ensure they are inheriting
# from this controller and not the main application's controller

module Booking
  class ApplicationController < ActionController::Base
  	
  end
end
