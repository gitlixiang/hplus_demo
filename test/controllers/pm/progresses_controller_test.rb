require 'test_helper'

class Pm::ProgressesControllerTest < ActionController::TestCase
  setup do
    @pm_progress = pm_progresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pm_progresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pm_progress" do
    assert_difference('Pm::Progress.count') do
      post :create, pm_progress: {content: @pm_progress.content, node: @pm_progress.node, node_id: @pm_progress.node_id, percent: @pm_progress.percent, plan_id: @pm_progress.plan_id, status: @pm_progress.status}
    end

    assert_redirected_to pm_progress_path(assigns(:pm_progress))
  end

  test "should show pm_progress" do
    get :show, id: @pm_progress
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pm_progress
    assert_response :success
  end

  test "should update pm_progress" do
    patch :update, id: @pm_progress, pm_progress: {content: @pm_progress.content, node: @pm_progress.node, node_id: @pm_progress.node_id, percent: @pm_progress.percent, plan_id: @pm_progress.plan_id, status: @pm_progress.status}
    assert_redirected_to pm_progress_path(assigns(:pm_progress))
  end

  test "should destroy pm_progress" do
    assert_difference('Pm::Progress.count', -1) do
      delete :destroy, id: @pm_progress
    end

    assert_redirected_to pm_progresses_path
  end
end
