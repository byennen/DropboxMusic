require 'test_helper'

class DropboxControllerTest < ActionController::TestCase
  test "should get authorize" do
    get :authorize
    assert_response :success
  end

  test "should get upload" do
    get :upload
    assert_response :success
  end

end
