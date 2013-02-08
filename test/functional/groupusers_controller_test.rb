require 'test_helper'

class GroupusersControllerTest < ActionController::TestCase
  setup do
    @groupuser = groupusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groupusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create groupuser" do
    assert_difference('Groupuser.count') do
      post :create, groupuser: {  }
    end

    assert_redirected_to groupuser_path(assigns(:groupuser))
  end

  test "should show groupuser" do
    get :show, id: @groupuser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @groupuser
    assert_response :success
  end

  test "should update groupuser" do
    put :update, id: @groupuser, groupuser: {  }
    assert_redirected_to groupuser_path(assigns(:groupuser))
  end

  test "should destroy groupuser" do
    assert_difference('Groupuser.count', -1) do
      delete :destroy, id: @groupuser
    end

    assert_redirected_to groupusers_path
  end
end
