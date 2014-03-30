require 'mail_view'

class MailPreview < MailView
  def place_orders
    delivery = Struct.new(:email).new('iets@iets.com')
    orders = Order.all
    OrderMailer.place_orders(orders, delivery)
  end
end
