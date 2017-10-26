require 'test_helper'

class TeachsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teachs_index_url
    assert_response :success
  end

  test "should get edit" do
    get teachs_edit_url
    assert_response :success
  end

  test "should get new" do
    get teachs_new_url
    assert_response :success
  end

  test "should get create" do
    get teachs_create_url
    assert_response :success
  end

  test "should get destroy" do
    get teachs_destroy_url
    assert_response :success
  end

end
