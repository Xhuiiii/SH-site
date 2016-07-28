require 'test_helper'

module Booking
  class TodaysBookingsControllerTest < ActionController::TestCase
    setup do
      @todays_booking = booking_todays_bookings(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:todays_bookings)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create todays_booking" do
      assert_difference('TodaysBooking.count') do
        post :create, todays_booking: { customer_ID: @todays_booking.customer_ID, date: @todays_booking.date, rate: @todays_booking.rate, reservation_ID: @todays_booking.reservation_ID, service_type_ID: @todays_booking.service_type_ID }
      end

      assert_redirected_to todays_booking_path(assigns(:todays_booking))
    end

    test "should show todays_booking" do
      get :show, id: @todays_booking
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @todays_booking
      assert_response :success
    end

    test "should update todays_booking" do
      patch :update, id: @todays_booking, todays_booking: { customer_ID: @todays_booking.customer_ID, date: @todays_booking.date, rate: @todays_booking.rate, reservation_ID: @todays_booking.reservation_ID, service_type_ID: @todays_booking.service_type_ID }
      assert_redirected_to todays_booking_path(assigns(:todays_booking))
    end

    test "should destroy todays_booking" do
      assert_difference('TodaysBooking.count', -1) do
        delete :destroy, id: @todays_booking
      end

      assert_redirected_to todays_bookings_path
    end
  end
end
