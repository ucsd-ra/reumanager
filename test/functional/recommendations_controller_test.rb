require File.dirname(__FILE__) + '/../test_helper'

class RecommendationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:recommendations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_recommendation
    assert_difference('Recommendation.count') do
      post :create, :recommendation => { }
    end

    assert_redirected_to recommendation_path(assigns(:recommendation))
  end

  def test_should_show_recommendation
    get :show, :id => recommendations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => recommendations(:one).id
    assert_response :success
  end

  def test_should_update_recommendation
    put :update, :id => recommendations(:one).id, :recommendation => { }
    assert_redirected_to recommendation_path(assigns(:recommendation))
  end

  def test_should_destroy_recommendation
    assert_difference('Recommendation.count', -1) do
      delete :destroy, :id => recommendations(:one).id
    end

    assert_redirected_to recommendations_path
  end
end
