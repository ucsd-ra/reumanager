require 'test_helper'

class RecommendationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recommendations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recommendation" do
    assert_difference('Recommendation.count') do
      post :create, :recommendation => { }
    end

    assert_redirected_to recommendation_path(assigns(:recommendation))
  end

  test "should show recommendation" do
    get :show, :id => recommendations(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => recommendations(:one).id
    assert_response :success
  end

  test "should update recommendation" do
    put :update, :id => recommendations(:one).id, :recommendation => { }
    assert_redirected_to recommendation_path(assigns(:recommendation))
  end

  test "should destroy recommendation" do
    assert_difference('Recommendation.count', -1) do
      delete :destroy, :id => recommendations(:one).id
    end

    assert_redirected_to recommendations_path
  end
end
