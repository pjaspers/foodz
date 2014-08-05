require "test_helper"

class UserTest < ActiveSupport::TestCase
  describe "sandwichles users" do
    it "are found based on the recent orders and placed orders" do
      User.expects(:active_usernames).returns(["soffe", "atog", "pjaspers"])
      User.expects(:ordered_usernames).returns(["soffe"])

      assert_equal ["atog", "pjaspers"], User.users_without_orders
    end
  end

end
