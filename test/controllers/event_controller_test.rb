require 'test_helper'

class EventControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get select_contacts" do
    get :select_contacts
    assert_response :success
  end

  test "should get select_destination" do
    get :select_destination
    assert_response :success
  end

  test "should get select_duration" do
    get :select_duration
    assert_response :success
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

end
