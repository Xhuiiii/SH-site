Booking::Engine.routes.draw do
  resources :customers
  resources :todays_bookings
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
