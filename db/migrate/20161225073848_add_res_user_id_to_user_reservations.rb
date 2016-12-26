class AddResUserIdToUserReservations < ActiveRecord::Migration
  def change
    add_column :booking_user_reservations, :reservation_id, :integer
    add_column :booking_user_reservations, :user_id, :integer
  end
end
