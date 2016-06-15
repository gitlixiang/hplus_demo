require 'test_helper'

class Pm::NodesControllerTest < ActionController::TestCase
  setup do
    @pm_node = pm_nodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pm_nodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pm_node" do
    assert_difference('Pm::Node.count') do
      post :create, pm_node: {content: @pm_node.content, end_date: @pm_node.end_date, name: @pm_node.name, percent: @pm_node.percent, plan_id: @pm_node.plan_id, sort_seq: @pm_node.sort_seq, start_date: @pm_node.start_date}
    end

    assert_redirected_to pm_node_path(assigns(:pm_node))
  end

  test "should show pm_node" do
    get :show, id: @pm_node
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pm_node
    assert_response :success
  end

  test "should update pm_node" do
    patch :update, id: @pm_node, pm_node: {content: @pm_node.content, end_date: @pm_node.end_date, name: @pm_node.name, percent: @pm_node.percent, plan_id: @pm_node.plan_id, sort_seq: @pm_node.sort_seq, start_date: @pm_node.start_date}
    assert_redirected_to pm_node_path(assigns(:pm_node))
  end

  test "should destroy pm_node" do
    assert_difference('Pm::Node.count', -1) do
      delete :destroy, id: @pm_node
    end

    assert_redirected_to pm_nodes_path
  end
end
