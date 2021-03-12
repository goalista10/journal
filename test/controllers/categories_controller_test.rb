require "test_helper"

class BlogControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Go to root " do
    #sign_in users(:user_001)

    get '/'
    assert_response :success
  end

  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end

  test "create category " do
    @first_user = User.first
    assert_difference '@first_user.categories.count' do
      post categories_path , params: { category: { name: "Test" } }
    end
  end

  test "go to edit category " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "test")
    new_category.save
    
    get edit_category_path(new_category)
    assert_response :success
  end

  test "edit category " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "test")
    new_category.save
    
    patch category_path(new_category) , params: { category: { name: "Test2" } }
    assert_response :redirect
  end

  test "delete category " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "test")
    new_category.save
    
    delete category_path(new_category)
    assert_response :redirect
  end

end