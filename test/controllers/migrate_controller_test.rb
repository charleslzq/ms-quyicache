require 'test_helper'

class MigrateControllerTest < ActionDispatch::IntegrationTest
  test "should get import" do
    get migrate_import_url
    assert_response :success
  end

end
