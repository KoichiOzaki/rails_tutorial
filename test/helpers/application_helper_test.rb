require 'test_helper'

class ApplicationHelperTest <  ActionView::TestCase
  test "full_title" do
    assert_equal full_title, "Rails | Ruby on Rails Tutorial Sample App"
    assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
  end
end
