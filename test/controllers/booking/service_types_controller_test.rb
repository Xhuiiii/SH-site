require 'test_helper'

module Booking
  class ServiceTypesControllerTest < ActionController::TestCase
    setup do
      @service_type = booking_service_types(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:service_types)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create service_type" do
      assert_difference('ServiceType.count') do
        post :create, service_type: { availability: @service_type.availability, max_occupancy: @service_type.max_occupancy, name: @service_type.name, price: @service_type.price }
      end

      assert_redirected_to service_type_path(assigns(:service_type))
    end

    test "should show service_type" do
      get :show, id: @service_type
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @service_type
      assert_response :success
    end

    test "should update service_type" do
      patch :update, id: @service_type, service_type: { availability: @service_type.availability, max_occupancy: @service_type.max_occupancy, name: @service_type.name, price: @service_type.price }
      assert_redirected_to service_type_path(assigns(:service_type))
    end

    test "should destroy service_type" do
      assert_difference('ServiceType.count', -1) do
        delete :destroy, id: @service_type
      end

      assert_redirected_to service_types_path
    end
  end
end
