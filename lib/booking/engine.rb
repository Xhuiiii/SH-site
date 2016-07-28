#Base class for the booking engine

module Booking
  class Engine < ::Rails::Engine
  	#Isolate the engine's classes to the applications
    isolate_namespace Booking

  end
end
