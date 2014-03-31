def import_food
  data = JSON.parse(File.open(File.join(Rails.root, "data", "prijslijst.json")).read)

  unless Delivery.find_by_name("A la minute")
    address = <<ADDRESS
Molenlei 51
2650 Edegem
ADDRESS

    delivery = Delivery.create(name: "A la minute", email: "sarahoefkens@hotmail.com", address: address, url: "http://alaminute.be")
  end

  data.each do |h|
    food = Food.find_or_create_by(name: h["name"])
    h.fetch("ingredients", "").split(",").map(&:strip).each do |i|
      ingredient = Ingredient.find_or_create_by(name: i)
      food.ingredients << ingredient
    end
    h.fetch("category", "").split(",").map(&:strip).each do |c|
      category = Category.find_or_create_by(name: c)
      food.categories << category
    end
    food.delivery = delivery
    food.save
  end
end

def import_previous_orders
  data = JSON.parse(File.open(File.join(Rails.root, "data", "previous_orders.to_json")).read)
  data.each do |h|
    unless order = Order.find_by(created_at: h["created_at"])
      Order.create(h)
    end
  end
end

import_food && import_previous_orders
