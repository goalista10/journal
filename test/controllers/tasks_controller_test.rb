require "test_helper"

class TaskControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end

  test "CREATE TASK " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "testCategory")
    new_category.save

    assert_difference 'new_category.tasks.count' do
      post category_tasks_path(new_category) , params: { task: { name: "TestTask" } }
    end
  end

  test "CREATE TASK FAIL because name cant be EMPTY" do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "testCategory")
    new_category.save

    assert_no_changes 'new_category.tasks.count' do
      post category_tasks_path(new_category) , params: { task: { name: "" } }
    end
  end

  test "CREATE TASK FAIL because name must be UNIQUE" do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "testCategory")
    new_category.save

    assert_difference 'new_category.tasks.count' do
      post category_tasks_path(new_category) , params: { task: { name: "TestTask" } }
    end

    assert_no_changes 'new_category.tasks.count' do
      post category_tasks_path(new_category) , params: { task: { name: "TestTask" } }
    end
  end

  test "GO to EDIT TASK " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "testCategory")
    new_category.save
    new_task = new_category.tasks.build(name: "testTask")
    new_task.save
    
    get edit_category_task_path(new_category,new_task)
    assert_response :success
  end

  test "EDIT TASK " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "testCategory")
    new_category.save
    new_task = new_category.tasks.build(name: "testTask")
    new_task.save

    assert_changes '@first_user.categories.find(new_category.id).tasks.find(new_task.id).name' do
      patch category_task_path(new_category,new_task) , params: { task: { name: "test2"} }
    end
  end

  test "EDIT TASK FAIL because name cant be EMPTY" do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "testCategory")
    new_category.save
    new_task = new_category.tasks.build(name: "testTask")
    new_task.save

    assert_no_changes '@first_user.categories.find(new_category.id).tasks.find(new_task.id).name' do
      patch category_task_path(new_category,new_task) , params: { task: { name: "" } }
    end
  end

  test "EDIT TASK FAIL because name must be UNIQUE" do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "testCategory")
    new_category.save
    new_task = new_category.tasks.build(name: "testTask")
    new_task.save
    another_task = new_category.tasks.build(name: "testTask2")
    another_task.save

    assert_no_changes '@first_user.categories.find(new_category.id).tasks.find(another_task.id).name' do
      patch category_task_path(new_category,another_task) , params: { task: { name: "testTask" } }
    end
  end

  test "DELETE TASK " do
    @first_user = User.first
    new_category = @first_user.categories.build(name: "testCategory")
    new_category.save
    new_task = new_category.tasks.build(name: "testTask")
    new_task.save
    
    assert_difference '@first_user.categories.find(new_category.id).tasks.count' , -1 do
      delete category_task_path(new_category,new_task)
    end
  end
end