require 'test_helper'

class Pm::StatisticsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
