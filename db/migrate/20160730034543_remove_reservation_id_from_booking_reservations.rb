class RemoveReservationIdFromBookingReservations < ActiveRecord::Migration
  def change
    remove_column :booking_reservations, :reservation_ID, :integer
  end
end
