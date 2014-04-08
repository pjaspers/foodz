class MailPreview < MailView
  def place_orders
    delivery = Struct.new(:email).new('iets@iets.com')
    orders = Order.all.limit(10)
    OrderMailer.place_orders(orders, delivery)
  end
end
