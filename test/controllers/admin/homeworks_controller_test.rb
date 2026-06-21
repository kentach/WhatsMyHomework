require "test_helper"

class Admin::HomeworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_homeworks_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_homeworks_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_homeworks_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_homeworks_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_homeworks_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_homeworks_destroy_url
    assert_response :success
  end
end
