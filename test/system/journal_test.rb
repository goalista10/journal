require "application_system_test_case"

class JournalTest < ApplicationSystemTestCase

  test "visit index" do
    sign_in users(:user_001)
    visit root_url
    sleep(inspection_time=1)
    
    assert_difference 'current_user.categories.count' do
      fill_in "Name", with: "Test category"
      sleep(inspection_time=1)
      click_on "Create Category"
      sleep(inspection_time=1)
    end

  end
end