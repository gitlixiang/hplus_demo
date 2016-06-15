require 'test_helper'

class Hr::LeaderSalariesControllerTest < ActionController::TestCase
  setup do
    @hr_leader_salary = hr_leader_salaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hr_leader_salaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hr_leader_salary" do
    assert_difference('Hr::LeaderSalary.count') do
      post :create, hr_leader_salary: {person_id: @hr_leader_salary.person_id}
    end

    assert_redirected_to hr_leader_salary_path(assigns(:hr_leader_salary))
  end

  test "should show hr_leader_salary" do
    get :show, id: @hr_leader_salary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hr_leader_salary
    assert_response :success
  end

  test "should update hr_leader_salary" do
    patch :update, id: @hr_leader_salary, hr_leader_salary: {person_id: @hr_leader_salary.person_id}
    assert_redirected_to hr_leader_salary_path(assigns(:hr_leader_salary))
  end

  test "should destroy hr_leader_salary" do
    assert_difference('Hr::LeaderSalary.count', -1) do
      delete :destroy, id: @hr_leader_salary
    end

    assert_redirected_to hr_leader_salaries_path
  end
end
