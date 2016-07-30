class RemoveServiceTypeIdFromBookingServiceTypes < ActiveRecord::Migration
  def change
    remove_column :booking_service_types, :service_type_ID, :integer
  end
end
