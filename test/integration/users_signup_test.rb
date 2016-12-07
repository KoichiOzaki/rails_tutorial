require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid sign up information" do
    get signup_path
    # assert_no_difference '比較したい変数' {ブロック}
    #  ->ブロック内の処理をした前後で引数の変数を比較し、変化がないことをテストする。
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:"",
        email: "user@invalid",
        pasword: "foo",
        password_confirmation: "bar"
      }}
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  test "valid sign up information" do
    get signup_path
    assert_difference 'User.count' do
      post signup_path, params: { user: { name: "Exaple User",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      }}
    end
    #follow_redirect!は単一のリダイレクトのレスポンスに従う。これがないとテスト内ではredirectされない。
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
