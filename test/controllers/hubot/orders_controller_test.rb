require "test_helper"

class Hubot::OrdersControllerTest < ActionController::TestCase

  it "gets all orders" do
    response = get :index
    assert JSON.parse(response.body).map{|h| h["metadata"]}.include?("Curryrol en mexicano")
  end

  it "can return only orders of asked day" do
    response = get :index, ordered_on: "2014-03-20"

    assert 1, JSON.parse(response.body).length
  end

  it "returns orders for today by default" do
    order = orders(:mexicano_and_curryrol)
    date_string = Date.today.strftime("%Y-%m-%d")
    Order.expects(:ordered_on).with(date_string).returns([order])
    response = get :index

    assert_equal 1, JSON.parse(response.body).length
  end

  it "returns orders all orders for non-date params" do
    Order.expects(:ordered_on).never
    response = get :index, ordered_on: "all"

    assert_equal 2, JSON.parse(response.body).length
  end

  it "creates an order from simple data" do
    assert_difference('Order.count') do
      post :create, {username: "pjaspers", metadata: "Mexicano met samurai"}, format: :json
    end

    assert_response :success
  end

  it "destroys an error if wanted" do
    Order.create!(username: "pjaspers", created_at: Time.now)
    assert_difference('Order.count', -1) do
      post :create, {username: "pjaspers", delete: "X"}, format: :json
    end

    assert_response :success
  end

  it "sends an email when sent a post request" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :mail
    end
    order_email = ActionMailer::Base.deliveries.last

    assert_equal 'piet@10to1.be', order_email.to[0]
  end
end
