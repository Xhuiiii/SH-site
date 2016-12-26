class AddUserIdAndCheckoutTimeToReservations < ActiveRecord::Migration
  def change
    add_column :booking_reservations, :user_id, :integer
    add_column :booking_reservations, :checkout_at, :time
  end
end
