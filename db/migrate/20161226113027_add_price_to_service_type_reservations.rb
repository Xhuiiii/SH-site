class AddPriceToServiceTypeReservations < ActiveRecord::Migration
  def change
    add_column :booking_service_type_reservations, :price, :float
  end
end
