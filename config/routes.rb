Booking::Engine.routes.draw do
  resources :customers
  resources :todays_bookings
  get 'reservations/display_prices', as: 'display_prices'
  get 'reservations/get_checkout_dates', as: 'get_checkout_dates'
  get 'reservations/display_multiple_day_services', as: 'display_multiple_day_services'
  get 'reservations/display_single_day_services', as: 'display_single_day_services'
  get 'reservations/display_timeslots', as: 'display_timeslots'
  get 'reservations/display_occupancy', as: 'display_occupancy'
  get 'reservations/display_child_occupancy', as: 'display_child_occupancy'
  resources :reservations
  resources :reservations do
	resources :service_type_reservations
  end
  resources :service_calendars, except: [:new]
  resources :categories
  resources :categories do
    resources :service_types, except: :index
  end
  resources :service_types, only: :index

  root to: "categories#index"

end
