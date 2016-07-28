class AddDateToBookingServiceTypes < ActiveRecord::Migration
  def change
    add_column :booking_service_types, :available_from, :date
    add_column :booking_service_types, :available_to, :date
  end
end
