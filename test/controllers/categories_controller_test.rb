require "test_helper"

class CategoryControllerTest < ActionDispatch::IntegrationTest
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

  test "CREATE CATEGORY " do
    @first_user = User.first
    assert_difference '@first_user.categories.count' do
      post categories_path , params: { category: { name: "Test" } }
    end
  end

  test "CREATE CATEGORY FAIL because name cant be EMPTY" do
    @first_user = User.first
    assert_no_changes '@first_user.categories.count' do
      post categories_path , params: { category: { name: "" } }
    end
  end

  test "CREATE CATEGORY FAIL because name must be UNIQUE" do
    @first_user = User.first

    assert_difference '@first_user.categories.count' do
      post categories_path , params: { category: { name: "Test" } }
    end

    assert_no_changes '@first_user.categories.count' do
      post categories_path , params: { category: { name: "Test" } }
    end
  end

  test "GO to EDIT CATEGORY " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "test")
    new_category.save
    
    get edit_category_path(new_category)
    assert_response :success
  end

  test "EDIT CATEGORY " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "test")
    new_category.save

    assert_changes '@first_user.categories.find(new_category.id).name' do
      patch category_path(new_category) , params: { category: { name: "test2"} }
    end
  end

  test "EDIT CATEGORY FAIL because name cant be EMPTY" do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "test")
    new_category.save
    
    assert_no_changes '@first_user.categories.find(new_category.id).name' do
      patch category_path(new_category) , params: { category: { name: "" } }
    end
  end

  test "EDIT CATEGORY FAIL because name must be UNIQUE" do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "test")
    new_category.save

    another_category = @first_user.categories.build(name: "test2")
    another_category.save
    
    assert_no_changes '@first_user.categories.find(another_category.id).name' do
      patch category_path(another_category) , params: { category: { name: "test" } }
    end
  end

  test "DELETE CATEGORY " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "test")
    new_category.save
    
    assert_difference '@first_user.categories.count', -1 do
      delete category_path(new_category) 
    end
  end
end