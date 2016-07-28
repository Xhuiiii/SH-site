class AddDefaultPriceValidToBookingServiceTypes < ActiveRecord::Migration
  def change
    add_column :booking_service_types, :default_price, :float
  end
end
