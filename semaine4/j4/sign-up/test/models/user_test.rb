require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Chantal", email: "goya@velefruit.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should be valid even empty" do
    check = User.new
    assert_not check.valid?
  end


  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should have 50 char max" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should have 250 char max" do
    @user.email = "a" * 251
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

end
