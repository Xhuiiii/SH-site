class CreateJoinTableBookingReservationBookingCustomer < ActiveRecord::Migration
  def change
    create_join_table :booking_reservations, :booking_customers do |t|
      # t.index [:booking_reservation_id, :booking_customer_id]
      # t.index [:booking_customer_id, :booking_reservation_id]
    end
  end
end
