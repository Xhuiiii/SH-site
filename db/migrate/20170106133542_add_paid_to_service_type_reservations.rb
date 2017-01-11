class AddPaidToServiceTypeReservations < ActiveRecord::Migration
  def change
    add_column :booking_service_type_reservations, :paid, :boolean
  end
end
