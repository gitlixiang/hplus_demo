require 'test_helper'

class Hr::SalariesControllerTest < ActionController::TestCase
  setup do
    @hr_salary = hr_salaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hr_salaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hr_salary" do
    assert_difference('Hr::Salary.count') do
      post :create, hr_salary: { allowance: @hr_salary.allowance, basic_salary: @hr_salary.basic_salary, full_attendance_bonus: @hr_salary.full_attendance_bonus, gross_salary: @hr_salary.gross_salary, holiday_overtime_hours: @hr_salary.holiday_overtime_hours, holiday_overtime_pay: @hr_salary.holiday_overtime_pay, housing_fund: @hr_salary.housing_fund, late: @hr_salary.late, late_times: @hr_salary.late_times, leave: @hr_salary.leave, leave_days: @hr_salary.leave_days, net_salary: @hr_salary.net_salary, other_deduction: @hr_salary.other_deduction, overtime_hours: @hr_salary.overtime_hours, overtime_pay: @hr_salary.overtime_pay, pay_for_performance: @hr_salary.pay_for_performance, performance_percent: @hr_salary.performance_percent, performance_standards: @hr_salary.performance_standards, personal_income_tax: @hr_salary.personal_income_tax, post_salary: @hr_salary.post_salary, social_insurance: @hr_salary.social_insurance, total_deduction: @hr_salary.total_deduction, total_overtime_pay: @hr_salary.total_overtime_pay }
    end

    assert_redirected_to hr_salary_path(assigns(:hr_salary))
  end

  test "should show hr_salary" do
    get :show, id: @hr_salary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hr_salary
    assert_response :success
  end

  test "should update hr_salary" do
    patch :update, id: @hr_salary, hr_salary: { allowance: @hr_salary.allowance, basic_salary: @hr_salary.basic_salary, full_attendance_bonus: @hr_salary.full_attendance_bonus, gross_salary: @hr_salary.gross_salary, holiday_overtime_hours: @hr_salary.holiday_overtime_hours, holiday_overtime_pay: @hr_salary.holiday_overtime_pay, housing_fund: @hr_salary.housing_fund, late: @hr_salary.late, late_times: @hr_salary.late_times, leave: @hr_salary.leave, leave_days: @hr_salary.leave_days, net_salary: @hr_salary.net_salary, other_deduction: @hr_salary.other_deduction, overtime_hours: @hr_salary.overtime_hours, overtime_pay: @hr_salary.overtime_pay, pay_for_performance: @hr_salary.pay_for_performance, performance_percent: @hr_salary.performance_percent, performance_standards: @hr_salary.performance_standards, personal_income_tax: @hr_salary.personal_income_tax, post_salary: @hr_salary.post_salary, social_insurance: @hr_salary.social_insurance, total_deduction: @hr_salary.total_deduction, total_overtime_pay: @hr_salary.total_overtime_pay }
    assert_redirected_to hr_salary_path(assigns(:hr_salary))
  end

  test "should destroy hr_salary" do
    assert_difference('Hr::Salary.count', -1) do
      delete :destroy, id: @hr_salary
    end

    assert_redirected_to hr_salaries_path
  end
end
