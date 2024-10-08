require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_index_url
    assert_response :success
  end

  test "should get upload" do
    get pages_upload_url
    assert_response :success
  end

  test "should get game" do
    get pages_game_url
    assert_response :success
  end
end
