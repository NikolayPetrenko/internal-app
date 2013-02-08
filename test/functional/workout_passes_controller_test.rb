require 'test_helper'

class WorkoutPassesControllerTest < ActionController::TestCase
  setup do
    @workout_pass = workout_passes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workout_passes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workout_pass" do
    assert_difference('WorkoutPass.count') do
      post :create, workout_pass: { end_time: @workout_pass.end_time, start_time: @workout_pass.start_time, total_time: @workout_pass.total_time }
    end

    assert_redirected_to workout_pass_path(assigns(:workout_pass))
  end

  test "should show workout_pass" do
    get :show, id: @workout_pass
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workout_pass
    assert_response :success
  end

  test "should update workout_pass" do
    put :update, id: @workout_pass, workout_pass: { end_time: @workout_pass.end_time, start_time: @workout_pass.start_time, total_time: @workout_pass.total_time }
    assert_redirected_to workout_pass_path(assigns(:workout_pass))
  end

  test "should destroy workout_pass" do
    assert_difference('WorkoutPass.count', -1) do
      delete :destroy, id: @workout_pass
    end

    assert_redirected_to workout_passes_path
  end
end
