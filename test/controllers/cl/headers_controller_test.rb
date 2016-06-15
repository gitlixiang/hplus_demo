require 'test_helper'

class Cl::HeadersControllerTest < ActionController::TestCase
  setup do
    @cl_header = cl_headers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cl_headers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cl_header" do
    assert_difference('Cl::Header.count') do
      post :create, cl_header: {code: @cl_header.code, name: @cl_header.name, order: @cl_header.order, resource_type: @cl_header.resource_type}
    end

    assert_redirected_to cl_header_path(assigns(:cl_header))
  end

  test "should show cl_header" do
    get :show, id: @cl_header
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cl_header
    assert_response :success
  end

  test "should update cl_header" do
    patch :update, id: @cl_header, cl_header: {code: @cl_header.code, name: @cl_header.name, order: @cl_header.order, resource_type: @cl_header.resource_type}
    assert_redirected_to cl_header_path(assigns(:cl_header))
  end

  test "should destroy cl_header" do
    assert_difference('Cl::Header.count', -1) do
      delete :destroy, id: @cl_header
    end

    assert_redirected_to cl_headers_path
  end
end
