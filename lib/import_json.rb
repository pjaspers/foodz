# {"name"=>"TONINO ", "ingredients"=>"tonijnsla, ui, augurk, martinosaus ", "category"=>"specialiteiten"}

data = JSON.parse(File.open(File.join(Rails.root, "prijslijst.json")).read)

address = <<ADDRESS
Molenlei 51
2650 Edegem
ADDRESS

delivery = Delivery.create(name: "A la minute", email: "sarahoefkens@hotmail.com", address: address, url: "http://alaminute.be")

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
