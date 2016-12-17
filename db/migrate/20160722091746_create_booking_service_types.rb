class CreateBookingServiceTypes < ActiveRecord::Migration
  def change
    create_table :booking_service_types do |t|
      t.string :name
      t.integer :max_occupancy
      t.integer :availability
      #availability is per day
      t.integer :special_availability
      t.text :description
      #special avail from-to
      t.date :available_from
      t.date :available_to
      t.float :special_price
      t.float :default_price
      t.boolean :booking_limit_bool
      t.integer :booking_limit
      t.boolean :adult_child_field
      t.boolean :adult_compulsory
      t.integer :max_adult_occupancy
      t.integer :max_child_occupancy
      # Service duration
      t.float :duration
      t.boolean :multiple_day
      t.integer :category_id

      t.boolean :special_mondays
      t.float :special_monday_price
      t.boolean :special_tuesdays
      t.float :special_tuesday_price
      t.boolean :special_wednesdays
      t.float :special_wednesday_price
      t.boolean :special_thursdays
      t.float :special_thursday_price
      t.boolean :special_fridays
      t.float :special_friday_price
      t.boolean :special_saturdays
      t.float :special_saturday_price
      t.boolean :special_sundays
      t.float :special_sunday_price

      t.timestamps null: false
    end
  end
end
