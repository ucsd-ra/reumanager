require 'test_helper'

class AcademicRecordsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:academic_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create academic_record" do
    assert_difference('AcademicRecord.count') do
      post :create, :academic_record => { }
    end

    assert_redirected_to academic_record_path(assigns(:academic_record))
  end

  test "should show academic_record" do
    get :show, :id => academic_records(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => academic_records(:one).id
    assert_response :success
  end

  test "should update academic_record" do
    put :update, :id => academic_records(:one).id, :academic_record => { }
    assert_redirected_to academic_record_path(assigns(:academic_record))
  end

  test "should destroy academic_record" do
    assert_difference('AcademicRecord.count', -1) do
      delete :destroy, :id => academic_records(:one).id
    end

    assert_redirected_to academic_records_path
  end
end
