require 'test_helper'

class MousaillonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mousaillons_index_url
    assert_response :success
  end

  test "should get show" do
    get mousaillons_show_url
    assert_response :success
  end

  test "should get new" do
    get mousaillons_new_url
    assert_response :success
  end

  test "should get create" do
    get mousaillons_create_url
    assert_response :success
  end

  test "should get destroy" do
    get mousaillons_destroy_url
    assert_response :success
  end

end
