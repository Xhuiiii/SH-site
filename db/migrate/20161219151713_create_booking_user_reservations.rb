class CreateBookingUserReservations < ActiveRecord::Migration
  def change
    create_table :booking_user_reservations do |t|

      t.timestamps null: false
    end
  end
end
