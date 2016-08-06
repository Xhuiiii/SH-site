class AddSpecialPriceToBookingServiceTypes < ActiveRecord::Migration
  def change
    add_column :booking_service_types, :special_price, :integer
  end
end
