class ChangeDateFormatInBookingServiceTypeReservations < ActiveRecord::Migration
  def change
  	change_column :booking_service_type_reservations, :date, :string
  end
end
