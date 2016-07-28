class AddIdToServiceTypes < ActiveRecord::Migration
  def change
    add_column :booking_service_types, :service_type_ID, :integer
  end
end
