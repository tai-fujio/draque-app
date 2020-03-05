require 'test_helper'

class BravesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get braves_update_url
    assert_response :success
  end

end
