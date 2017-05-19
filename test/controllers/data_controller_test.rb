require 'test_helper'

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get appHospital" do
    get data_appHospital_url
    assert_response :success
  end

  test "should get medicineShop" do
    get data_medicineShop_url
    assert_response :success
  end

  test "should get dictCode" do
    get data_dictCode_url
    assert_response :success
  end

end
