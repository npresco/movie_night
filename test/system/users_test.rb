require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def test_visiting_root_redirects_to_login
    visit_with_http_auth root_url

    # Auth fields
    has_field? :email
    has_field? :password
  end

  def test_creating_user
    visit_with_http_auth root_url

    click_on "Sign Up"
    fill_in "Name", with: "John"
    fill_in "Email", with: "hello@john.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Submit"

    # take_screenshot
    has_content? "Welcome John"
  end

  # Creating a club
  # Adding a movie to a list
  # Removig a movie
end
