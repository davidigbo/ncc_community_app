require "test_helper"

class Admin::EventRegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_event_registrations_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_event_registrations_show_url
    assert_response :success
  end

  test "should get update" do
    get admin_event_registrations_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_event_registrations_destroy_url
    assert_response :success
  end
end
