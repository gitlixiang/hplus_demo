require 'test_helper'

class Pm::TasksControllerTest < ActionController::TestCase
  setup do
    @pm_task = pm_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pm_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pm_task" do
    assert_difference('Pm::Task.count') do
      post :create, pm_task: {content: @pm_task.content, name: @pm_task.name, org_id: @pm_task.org_id, resource_id: @pm_task.resource_id}
    end

    assert_redirected_to pm_task_path(assigns(:pm_task))
  end

  test "should show pm_task" do
    get :show, id: @pm_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pm_task
    assert_response :success
  end

  test "should update pm_task" do
    patch :update, id: @pm_task, pm_task: {content: @pm_task.content, name: @pm_task.name, org_id: @pm_task.org_id, resource_id: @pm_task.resource_id}
    assert_redirected_to pm_task_path(assigns(:pm_task))
  end

  test "should destroy pm_task" do
    assert_difference('Pm::Task.count', -1) do
      delete :destroy, id: @pm_task
    end

    assert_redirected_to pm_tasks_path
  end
end
