require 'test_helper'

class HouseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get house_index_url
    assert_response :success
  end

  test "should get new" do
    get house_new_url
    assert_response :success
  end

  test "should get create" do
    get house_create_url
    assert_response :success
  end

  test "should get listing" do
    get house_listing_url
    assert_response :success
  end

  test "should get pricing" do
    get house_pricing_url
    assert_response :success
  end

  test "should get description" do
    get house_description_url
    assert_response :success
  end

  test "should get photo_upload" do
    get house_photo_upload_url
    assert_response :success
  end

  test "should get amenities" do
    get house_amenities_url
    assert_response :success
  end

  test "should get location" do
    get house_location_url
    assert_response :success
  end

  test "should get update" do
    get house_update_url
    assert_response :success
  end

end
