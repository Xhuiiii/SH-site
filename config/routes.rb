Booking::Engine.routes.draw do
  resources :customers
  resources :todays_bookings
  resources :reservations
  resources :service_calendars, except: [:new]
  resources :service_types
  resources :tmpls

  root to: "service_types#index"

end
