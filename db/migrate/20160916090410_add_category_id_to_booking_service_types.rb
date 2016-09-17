class AddCategoryIdToBookingServiceTypes < ActiveRecord::Migration
  def change
  	add_column :booking_service_types, :category_id, :integer
  end
end
