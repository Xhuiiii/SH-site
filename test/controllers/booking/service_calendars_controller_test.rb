require 'test_helper'

module Booking
  class ServiceCalendarsControllerTest < ActionController::TestCase
    setup do
      @service_calendar = booking_service_calendars(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:service_calendars)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create service_calendar" do
      assert_difference('ServiceCalendar.count') do
        post :create, service_calendar: { availability: @service_calendar.availability, date: @service_calendar.date, rate: @service_calendar.rate, reservation: @service_calendar.reservation, service_type_ID: @service_calendar.service_type_ID }
      end

      assert_redirected_to service_calendar_path(assigns(:service_calendar))
    end

    test "should show service_calendar" do
      get :show, id: @service_calendar
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @service_calendar
      assert_response :success
    end

    test "should update service_calendar" do
      patch :update, id: @service_calendar, service_calendar: { availability: @service_calendar.availability, date: @service_calendar.date, rate: @service_calendar.rate, reservation: @service_calendar.reservation, service_type_ID: @service_calendar.service_type_ID }
      assert_redirected_to service_calendar_path(assigns(:service_calendar))
    end

    test "should destroy service_calendar" do
      assert_difference('ServiceCalendar.count', -1) do
        delete :destroy, id: @service_calendar
      end

      assert_redirected_to service_calendars_path
    end
  end
end
