require "test_helper"

class FoodTest < ActiveSupport::TestCase
  describe "loading the fixture" do
    before do
      @food = foods(:mexicano)
    end

    it "sets the name" do
      assert_equal "Smos Mexicano", @food.name
    end

    it "has ingredients" do
      assert @food.ingredients.length > 1
    end

    it "has lettuce as a ingredient" do
      assert @food.ingredients.include?(ingredients(:lettuce))
    end

    it "belongs to a la minute" do
      assert_equal deliveries(:a_la_minute), @food.delivery
    end

    it "is added to a line item" do
      assert @food.lines.include?(lines(:mexicano_line))
    end
  end
end
