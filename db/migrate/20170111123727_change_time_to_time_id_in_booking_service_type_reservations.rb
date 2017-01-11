class ChangeTimeToTimeIdInBookingServiceTypeReservations < ActiveRecord::Migration
  def change
    add_column :booking_service_type_reservations, :time_id, :integer
  end
end
