require 'test_helper'

class DesignersControllerTest < ActionController::TestCase
  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end
