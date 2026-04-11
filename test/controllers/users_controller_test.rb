require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: "new@example.com", name: "New User", password: "password123" } }, as: :json
    end

    assert_response :created
  end

  test "should generate token on user create" do
    post users_url, params: { user: { email: "test_token@example.com", name: "Test Token", password: "password123" } }, as: :json

    assert_response :created
    response_body = JSON.parse(@response.body)
    assert response_body.key?("meta") && response_body["meta"].key?("token"), "Token should be present in response meta"
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    user = User.create!(email: "update@test.com", name: "Update User", password: "password")
    token = JsonWebToken.encode(user_id: user.id)
    patch user_url(user), params: { user: { email: "updated@test.com" } }, headers: { "Authorization" => "Bearer #{token}" }, as: :json
    assert_response :success
  end

  test "should destroy user" do
    user = User.create!(email: "delete@test.com", name: "Delete User", password: "password")
    token = JsonWebToken.encode(user_id: user.id)
    assert_difference("User.count", -1) do
      delete user_url(user), headers: { "Authorization" => "Bearer #{token}" }, as: :json
    end

    assert_response :no_content
  end
end
