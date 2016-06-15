require 'test_helper'

class Pm::CommentsControllerTest < ActionController::TestCase
  setup do
    @pm_comment = pm_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pm_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pm_comment" do
    assert_difference('Pm::Comment.count') do
      post :create, pm_comment: {comment_time: @pm_comment.comment_time, content: @pm_comment.content, resource_id: @pm_comment.resource_id, user_id: @pm_comment.user_id}
    end

    assert_redirected_to pm_comment_path(assigns(:pm_comment))
  end

  test "should show pm_comment" do
    get :show, id: @pm_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pm_comment
    assert_response :success
  end

  test "should update pm_comment" do
    patch :update, id: @pm_comment, pm_comment: {comment_time: @pm_comment.comment_time, content: @pm_comment.content, resource_id: @pm_comment.resource_id, user_id: @pm_comment.user_id}
    assert_redirected_to pm_comment_path(assigns(:pm_comment))
  end

  test "should destroy pm_comment" do
    assert_difference('Pm::Comment.count', -1) do
      delete :destroy, id: @pm_comment
    end

    assert_redirected_to pm_comments_path
  end
end
