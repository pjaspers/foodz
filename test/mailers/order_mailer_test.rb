require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "place_orders" do
    fake_delivery = Struct.new(:email).new(['me@example.com', 'you@example.com'])
    email = OrderMailer.place_orders(Order.none, fake_delivery).deliver

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['me@example.com', 'you@example.com'], email.to
  end
end
