require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get posts_home_url
    assert_response :success
  end

  test "should get about" do
    get posts_about_url
    assert_response :success
  end
end
