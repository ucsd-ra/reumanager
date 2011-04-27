require 'test_helper'

class RecommendersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recommenders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recommender" do
    assert_difference('Recommender.count') do
      post :create, :recommender => { }
    end

    assert_redirected_to recommender_path(assigns(:recommender))
  end

  test "should show recommender" do
    get :show, :id => recommenders(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => recommenders(:one).id
    assert_response :success
  end

  test "should update recommender" do
    put :update, :id => recommenders(:one).id, :recommender => { }
    assert_redirected_to recommender_path(assigns(:recommender))
  end

  test "should destroy recommender" do
    assert_difference('Recommender.count', -1) do
      delete :destroy, :id => recommenders(:one).id
    end

    assert_redirected_to recommenders_path
  end
end
