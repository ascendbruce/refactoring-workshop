require 'rails_helper'
require 'support/macros'

feature "Admin adds new video" do

  scenario "Admin successfully adds a new video" do
    user_id = 1

    # with valid inputs
    visit edit_user_path(user_id)

    fill_in_default
    click_button "Update User"

    expect(page).to have_content "feature_test@testing.com"
    expect(page).to have_content "FeatureTestNickname"
    expect(page).to have_content "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

    # wrong email format
    visit edit_user_path(user_id)

    fill_in_default
    fill_in "Email", with: "feature_test at testing dot com"
    click_button "Update User"

    expect(page).to have_content "Email is invalid"
    expect_show_page_did_not_change_after_update(user_id)

    # feature_test_show(user_id)

    # email not present
    visit edit_user_path(user_id)

    fill_in_default
    fill_in "Email", with: ""
    click_button "Update User"

    expect(page).to have_content "Email can't be blank"
    expect_show_page_did_not_change_after_update(user_id)

    # nickname not present
    visit edit_user_path(user_id)

    fill_in_default
    fill_in "Nickname", with: ""
    click_button "Update User"

    expect(page).to have_content "ickname can't be blank"
    expect_show_page_did_not_change_after_update(user_id)

    # nickname is too short
    visit edit_user_path(user_id)

    fill_in_default
    fill_in "Nickname", with: "ab"
    click_button "Update User"

    expect(page).to have_content "ickname is too short"

    # bio not present
    visit edit_user_path(user_id)

    fill_in_default
    fill_in "Bio", with: ""
    click_button "Update User"

    expect(page).to have_content "io can't be blank"
    expect_show_page_did_not_change_after_update(user_id)
  end
end
