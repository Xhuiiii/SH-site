Booking::Engine.routes.draw do
  get "reservations" => 'reservations#show'
  post "reservation/add" => "reservations#add", :as => :add_to_reservation
  post "reservation/remove/:id" => "reservations#remove", :as => :remove_from_reservation

  devise_for :users, {
    class_name: "Booking::User",
    module: :devise,
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords"
    }
  }

  resources :customers
  resources :todays_bookings

  get 'service_type_reservations/display_prices', as: 'display_prices'
  get 'service_type_reservations/get_checkout_dates', as: 'get_checkout_dates'
  get 'service_type_reservations/display_multiple_day_services', as: 'display_multiple_day_services'
  get 'service_type_reservations/display_single_day_services', as: 'display_single_day_services'
  get 'service_type_reservations/display_timeslots', as: 'display_timeslots'
  get 'service_type_reservations/display_occupancy', as: 'display_occupancy'
  get 'service_type_reservations/display_child_occupancy', as: 'display_child_occupancy'
  resources :service_type_reservations

  resources :service_calendars, except: [:new]
  resources :categories
  resources :categories do
    resources :service_types, except: :index
  end
  resources :service_types, only: :index

  root to: "booking/categories#index"
end
