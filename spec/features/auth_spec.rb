require 'spec_helper'

describe "the signup process" do
  it "has a new user page" do
    visit "/users/new"
    expect(page).to have_content("Sign Up")
  end

  describe "signing up a user" do
    it "shows username on the homepage after signup" do
      sign_up('testuser', 'password')
      expect(page).to have_content('testuser')
    end
  end

end

describe "logging in" do
  it "shows username on the homepage after login" do
    sign_up('testuser', 'password')
    click_button "Log Out"

    visit new_session_url
    fill_in "Username", with: 'testuser'
    fill_in "Password", with: 'password'
    click_button "Sign In"
    expect(page).to have_content('testuser')
  end
end

describe "logging out" do
  it "begins with logged out state" do
    visit new_session_url
    expect(page).not_to have_content('testuser')
  end

  it "doesn't show username on the homepage after logout" do
    sign_up('testuser', 'password')
    click_button "Log Out"

    visit new_session_url
    fill_in "Username", with: 'testuser'
    fill_in "Password", with: 'password'
    click_button "Sign In"
    save_and_open_page
    click_button "Log Out"
    expect(page).not_to have_content('testuser')
  end
end