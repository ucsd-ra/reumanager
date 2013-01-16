require 'test_helper'

class ExtrasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extra" do
    assert_difference('Extra.count') do
      post :create, :extra => { }
    end

    assert_redirected_to extra_path(assigns(:extra))
  end

  test "should show extra" do
    get :show, :id => extras(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => extras(:one).id
    assert_response :success
  end

  test "should update extra" do
    put :update, :id => extras(:one).id, :extra => { }
    assert_redirected_to extra_path(assigns(:extra))
  end

  test "should destroy extra" do
    assert_difference('Extra.count', -1) do
      delete :destroy, :id => extras(:one).id
    end

    assert_redirected_to extras_path
  end
end
