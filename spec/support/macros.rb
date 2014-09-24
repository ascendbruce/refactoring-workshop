def expect_show_page_did_not_change_after_update(user_id)
  visit user_path(user_id)
  expect(page).to have_content "feature_test@testing.com"
  expect(page).to have_content "FeatureTestNickname"
  expect(page).to have_content "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
end


def fill_in_default
  fill_in "Email",    with: "feature_test@testing.com"
  fill_in "Nickname", with: "FeatureTestNickname"
  fill_in "Bio",      with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
end
