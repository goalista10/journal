require 'test_helper'

class CreateUserTest < ActionDispatch::IntegrationTest
    test "should make new user" do
        get new_user_registration_path
        assert_response :success
        assert_difference 'User.count', 1 do
            post user_registration_path, params: { user: { email: "testaa@test.com", username: "test",password:"testtest" } }
            assert_response :success
        end
    end
end