require 'test_helper'

class Hr::PersonHistoriesControllerTest < ActionController::TestCase
  setup do
    @hr_person_history = hr_person_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hr_person_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hr_person_history" do
    assert_difference('Hr::PersonHistory.count') do
      post :create, hr_person_history: {full_name: @hr_person_history.full_name}
    end

    assert_redirected_to hr_person_history_path(assigns(:hr_person_history))
  end

  test "should show hr_person_history" do
    get :show, id: @hr_person_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hr_person_history
    assert_response :success
  end

  test "should update hr_person_history" do
    patch :update, id: @hr_person_history, hr_person_history: {full_name: @hr_person_history.full_name}
    assert_redirected_to hr_person_history_path(assigns(:hr_person_history))
  end

  test "should destroy hr_person_history" do
    assert_difference('Hr::PersonHistory.count', -1) do
      delete :destroy, id: @hr_person_history
    end

    assert_redirected_to hr_person_histories_path
  end
end
