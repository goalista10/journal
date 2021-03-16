require "application_system_test_case"

class JournalTest < ApplicationSystemTestCase
  test "visit index and crud" do
    sign_in users(:user_001)
    visit root_url
    sleep(inspection_time=1)
    
    current_user = User.first

    assert_selector "h1", text: current_user.username

    assert_difference 'current_user.categories.count' do
      fill_in "Name", with: "Test category"
      sleep(inspection_time=1)
      click_on "Create Category"
      sleep(inspection_time=1)
    end

    assert_difference 'current_user.categories.count', -1 do
      accept_alert do
        first(:link, "Remove").click
        sleep(inspection_time=1)
      end
      sleep(inspection_time=1)
    end

    first(:link, "Edit", exact: true).click
    sleep(inspection_time=1)
    fill_in "Name", with: "Test category2"
    sleep(inspection_time=1)
    click_on "Update Category"
    sleep(inspection_time=1)

    first(:link, "Tasks", exact: true).click
    sleep(inspection_time=1)
    fill_in "Name", with: "Test Task"
    sleep(inspection_time=1)
    click_on "Create Task"
    sleep(inspection_time=1)

    first(:link, "Edit", exact: true).click
    sleep(inspection_time=1)
    fill_in "Name", with: "Test Task2"
    sleep(inspection_time=1)
    click_on "Update Task"
    sleep(inspection_time=1)
  end
end