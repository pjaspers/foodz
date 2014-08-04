require "test_helper"

class Hubot::UsersControllerTest < ActionController::TestCase

  it "lists sandwichless usernames" do
    Order.expects(:sandwichless_usernames).returns(["bob"])
    response = get :sandwichless
    assert_equal ["bob"], JSON.parse(response.body)
  end

end
