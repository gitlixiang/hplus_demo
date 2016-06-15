require 'test_helper'

class Cl::ContentsControllerTest < ActionController::TestCase
  setup do
    @cl_content = cl_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cl_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cl_content" do
    assert_difference('Cl::Content.count') do
      post :create, cl_content: {code: @cl_content.code, col: @cl_content.col, cols: @cl_content.cols, header_id: @cl_content.header_id, name: @cl_content.name, row: @cl_content.row, rows: @cl_content.rows}
    end

    assert_redirected_to cl_content_path(assigns(:cl_content))
  end

  test "should show cl_content" do
    get :show, id: @cl_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cl_content
    assert_response :success
  end

  test "should update cl_content" do
    patch :update, id: @cl_content, cl_content: {code: @cl_content.code, col: @cl_content.col, cols: @cl_content.cols, header_id: @cl_content.header_id, name: @cl_content.name, row: @cl_content.row, rows: @cl_content.rows}
    assert_redirected_to cl_content_path(assigns(:cl_content))
  end

  test "should destroy cl_content" do
    assert_difference('Cl::Content.count', -1) do
      delete :destroy, id: @cl_content
    end

    assert_redirected_to cl_contents_path
  end
end
