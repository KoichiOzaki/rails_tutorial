require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example User", email:"user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "shold be valid" do
    assert @user.valid?
  end

  test "name shold be presence" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = ("a" * 244) + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com
                        User@foo.COM
                        A_US-ER@foo.bar.org
                        firsr.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses"do
    invalid_adrreses = %w[foo@bar..com
                          user@example,com
                          user_att_foo.com
                          user.name@example.
                          foo@bar_baz.com
                          foo@bar+baz.com]
    invalid_adrreses.each do |valid_address|
      @user.email = valid_address
      assert_not @user.valid?, "#{valid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    #要注意！！メールアドレスは大文字小文字を認識しないため大文字にして重複テスト
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?, "#{duplicate_user.email.inspect} should be invalid"
  end

  test "email should be saved as lower case" do
    mixed_case_email = "Foo@Bar.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase , @user.reload.email

    # reloadすると読み直す
    # >> user.email
    #  => "mhartl@example.net"
    # >> user.email = "foo@bar.com"
    #   => "foo@bar.com"
    # >> user.reload.email
    #   => "mhartl@example.net"
  end

  test "password should be present(not blank)" do
    @user.password = @user.password_confirmation = "" * 5
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end


# test用のDBについてはどのタイミングで初期化されているのか？