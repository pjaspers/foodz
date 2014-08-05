require "test_helper"

class OrderTest < ActiveSupport::TestCase
  describe "loading from ashes" do
    before do
      @hash = {"metadata"=>"ne midden fitness dalton", "created_at"=>"2011-11-04T08:22:15Z", "username"=>"Piet Jaspers"}
      @order = Order.create(@hash)
    end

    it "sets created_at" do
      assert_equal 2011, @order.created_at.year
    end

    it "sets username" do
      assert_equal "Piet Jaspers", @order.username
    end
  end

  describe "scopes" do

    it "finds old orders" do
      o = Order.create({"metadata"=>"ne midden fitness dalton", "created_at"=>"2011-11-04T08:22:15Z", "username"=>"Piet Jaspers"})
      assert Order.ordered_on(Date.new(2011, 11, 04)).include? o
    end

    it "finds orders for today" do
      Order.expects(:ordered_on).with(Date.today.strftime("%Y-%m-%d")).once
      Order.today
    end

    it "finds all orders since a date" do
      o1 = Order.create({"metadata"=>"ne midden fitness dalton", "created_at"=>"2011-11-04T08:22:15Z", "username"=>"Piet Jaspers"})
      o2 = Order.create({"metadata"=>"ne midden fitness dalton", "created_at"=>"2014-11-04T08:22:15Z", "username"=>"Piet Jaspers"})
      assert Order.ordered_since(Date.new(2011, 11, 04)).include? o1
      assert Order.ordered_since(Date.new(2011, 11, 04)).include? o2
    end

  end

end
