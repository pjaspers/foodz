class OrderMailer < ActionMailer::Base
  default from: "from@example.com"

  def place_orders(orders, delivery)
    @delivery = delivery
    @orders = orders
    mail(to: @delivery.email, subject: 'Broodjes bestelling voor 10to1')
  end
end
