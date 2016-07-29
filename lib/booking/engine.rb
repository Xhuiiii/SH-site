#Base class for the booking engine

module Booking
  class Engine < ::Rails::Engine
  	#Isolate the engine's classes to the applications
    isolate_namespace Booking
    initializer 'booking.load_booking' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
  end
end
