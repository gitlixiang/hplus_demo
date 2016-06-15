require 'test_helper'

class Hr::EarlyWarningsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
