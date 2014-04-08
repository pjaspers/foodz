desc "This task is called by the Heroku scheduler add-on"
task :mail_orders => :environment do
  puts "Mailing orders..."
  fake_delivery = Struct.new(:email).new("piet@10to1.be")
  OrderMailer.place_orders(Order.today, fake_delivery).deliver
  puts "done."
end
