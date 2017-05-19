require 'test_helper'

class CacheControllerTest < ActionDispatch::IntegrationTest
  test "should get getByTypeId" do
    get cache_getByTypeId_url
    assert_response :success
  end

  test "should get getByCodeId" do
    get cache_getByCodeId_url
    assert_response :success
  end

  test "should get refresh" do
    get cache_refresh_url
    assert_response :success
  end

end
