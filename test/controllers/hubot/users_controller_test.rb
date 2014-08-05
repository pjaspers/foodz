require "test_helper"

class Hubot::UsersControllerTest < ActionController::TestCase

  it "lists sandwichless usernames" do
    User.expects(:users_without_orders).returns(["bob"])
    response = get :sandwichless
    assert_equal ["bob"], JSON.parse(response.body)
  end

end
