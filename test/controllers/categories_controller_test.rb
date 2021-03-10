require "test_helper"

class BlogControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Go to root " do
    #sign_in users(:user_001)

    get '/'
    assert_response :success
  end

  test "create category " do
    sign_in users(:user_001)

    assert_difference 'current_user.categories.count' do
      post categories_path , params: { category: { name: "Test" } }
    end
  end

  test "go to edit category " do
    sign_in users(:user_001)

    new_category = current_user.categories.build(name: "test", user_id: current_user.id)
    new_category.save

    get edit_category_path(new_category.id)
    assert_response :success
  end

end