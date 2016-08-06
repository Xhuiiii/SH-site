class CreateBookingServiceTypes < ActiveRecord::Migration
  def change
    create_table :booking_service_types do |t|
      t.string :name
      t.integer :max_occupancy
      t.float :price
      t.integer :availability
      t.text :description
      t.date :available_from
      t.date :available_to
      t.float :default_price

      t.timestamps null: false
    end
  end
end
