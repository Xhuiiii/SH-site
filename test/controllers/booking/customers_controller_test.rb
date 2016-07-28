require 'test_helper'

module Booking
  class CustomersControllerTest < ActionController::TestCase
    setup do
      @customer = booking_customers(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:customers)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create customer" do
      assert_difference('Customer.count') do
        post :create, customer: { address: @customer.address, city: @customer.city, country: @customer.country, email: @customer.email, first_name: @customer.first_name, last_name: @customer.last_name, phone: @customer.phone, state: @customer.state, title: @customer.title, zip: @customer.zip }
      end

      assert_redirected_to customer_path(assigns(:customer))
    end

    test "should show customer" do
      get :show, id: @customer
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @customer
      assert_response :success
    end

    test "should update customer" do
      patch :update, id: @customer, customer: { address: @customer.address, city: @customer.city, country: @customer.country, email: @customer.email, first_name: @customer.first_name, last_name: @customer.last_name, phone: @customer.phone, state: @customer.state, title: @customer.title, zip: @customer.zip }
      assert_redirected_to customer_path(assigns(:customer))
    end

    test "should destroy customer" do
      assert_difference('Customer.count', -1) do
        delete :destroy, id: @customer
      end

      assert_redirected_to customers_path
    end
  end
end
