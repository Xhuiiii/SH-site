class CreateBookingServiceTypes < ActiveRecord::Migration
  def change
    create_table :booking_service_types do |t|
      t.string :name
      t.integer :max_occupancy
      t.float :price
      t.integer :availability

      t.timestamps null: false
    end
  end
end
