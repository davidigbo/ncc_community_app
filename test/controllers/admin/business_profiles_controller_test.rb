require "test_helper"

class Admin::BusinessProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_business_profiles_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_business_profiles_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_business_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_business_profiles_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_business_profiles_destroy_url
    assert_response :success
  end
end
