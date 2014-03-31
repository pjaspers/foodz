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
end
