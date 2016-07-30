class AddTimeToBookingReservations < ActiveRecord::Migration
  def change
    add_column :booking_reservations, :time, :time
  end
end
