require 'test_helper'

class Hr::PeopleControllerTest < ActionController::TestCase
  setup do
    @hr_person = hr_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hr_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hr_person" do
    assert_difference('Hr::Person.count') do
      post :create, hr_person: {full_name: @hr_person.full_name}
    end

    assert_redirected_to hr_person_path(assigns(:hr_person))
  end

  test "should show hr_person" do
    get :show, id: @hr_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hr_person
    assert_response :success
  end

  test "should update hr_person" do
    patch :update, id: @hr_person, hr_person: {full_name: @hr_person.full_name}
    assert_redirected_to hr_person_path(assigns(:hr_person))
  end

  test "should destroy hr_person" do
    assert_difference('Hr::Person.count', -1) do
      delete :destroy, id: @hr_person
    end

    assert_redirected_to hr_people_path
  end
end
