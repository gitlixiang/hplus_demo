require 'test_helper'

class Pm::PlansControllerTest < ActionController::TestCase
  setup do
    @pm_plan = pm_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pm_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pm_plan" do
    assert_difference('Pm::Plan.count') do
      post :create, pm_plan: {contact: @pm_plan.contact, content: @pm_plan.content, name: @pm_plan.name, org_id: @pm_plan.org_id, phone: @pm_plan.phone}
    end

    assert_redirected_to pm_plan_path(assigns(:pm_plan))
  end

  test "should show pm_plan" do
    get :show, id: @pm_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pm_plan
    assert_response :success
  end

  test "should update pm_plan" do
    patch :update, id: @pm_plan, pm_plan: {contact: @pm_plan.contact, content: @pm_plan.content, name: @pm_plan.name, org_id: @pm_plan.org_id, phone: @pm_plan.phone}
    assert_redirected_to pm_plan_path(assigns(:pm_plan))
  end

  test "should destroy pm_plan" do
    assert_difference('Pm::Plan.count', -1) do
      delete :destroy, id: @pm_plan
    end

    assert_redirected_to pm_plans_path
  end
end
