require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count', 'An user should not be created' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end 
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'div#error_explanation li'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1, 'An user should be created' do
      post users_path, params: { user: { name:  "Example",
                                         email: "example@example.com",
                                         password:              "example",
                                         password_confirmation: "example" } }
    end 
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
