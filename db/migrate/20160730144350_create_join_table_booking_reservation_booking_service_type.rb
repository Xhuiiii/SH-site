class CreateJoinTableBookingReservationBookingServiceType < ActiveRecord::Migration
  def change
    create_join_table :booking_reservations, :booking_service_types do |t|
      # t.index [:booking_reservation_id, :booking_service_type_id]
      # t.index [:booking_service_type_id, :booking_reservation_id]
    end
  end
end
