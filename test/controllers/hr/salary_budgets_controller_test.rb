require 'test_helper'

class Hr::SalaryBudgetsControllerTest < ActionController::TestCase
  setup do
    @hr_salary_budget = hr_salary_budgets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hr_salary_budgets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hr_salary_budget" do
    assert_difference('Hr::SalaryBudget.count') do
      post :create, hr_salary_budget: {basic_salary: @hr_salary_budget.basic_salary, gross_salary: @hr_salary_budget.gross_salary, housing_fund: @hr_salary_budget.housing_fund, net_salary: @hr_salary_budget.net_salary, org_id: @hr_salary_budget.org_id, pay_for_performance: @hr_salary_budget.pay_for_performance, personal_income_tax: @hr_salary_budget.personal_income_tax, remark: @hr_salary_budget.remark, remark: @hr_salary_budget.remark, social_insurance: @hr_salary_budget.social_insurance, status: @hr_salary_budget.status, total_deduction: @hr_salary_budget.total_deduction, total_overtime_pay: @hr_salary_budget.total_overtime_pay, year: @hr_salary_budget.year}
    end

    assert_redirected_to hr_salary_budget_path(assigns(:hr_salary_budget))
  end

  test "should show hr_salary_budget" do
    get :show, id: @hr_salary_budget
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hr_salary_budget
    assert_response :success
  end

  test "should update hr_salary_budget" do
    patch :update, id: @hr_salary_budget, hr_salary_budget: {basic_salary: @hr_salary_budget.basic_salary, gross_salary: @hr_salary_budget.gross_salary, housing_fund: @hr_salary_budget.housing_fund, net_salary: @hr_salary_budget.net_salary, org_id: @hr_salary_budget.org_id, pay_for_performance: @hr_salary_budget.pay_for_performance, personal_income_tax: @hr_salary_budget.personal_income_tax, remark: @hr_salary_budget.remark, remark: @hr_salary_budget.remark, social_insurance: @hr_salary_budget.social_insurance, status: @hr_salary_budget.status, total_deduction: @hr_salary_budget.total_deduction, total_overtime_pay: @hr_salary_budget.total_overtime_pay, year: @hr_salary_budget.year}
    assert_redirected_to hr_salary_budget_path(assigns(:hr_salary_budget))
  end

  test "should destroy hr_salary_budget" do
    assert_difference('Hr::SalaryBudget.count', -1) do
      delete :destroy, id: @hr_salary_budget
    end

    assert_redirected_to hr_salary_budgets_path
  end
end
