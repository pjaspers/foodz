  def fake_emails
    Rails.application.secrets.fake_delivery_emails.split(",").collect(&:strip)
  end

  desc "This task is called by the Heroku scheduler add-on"
  task :mail_orders => :environment do
    puts "Mailing orders..."
    fake_delivery = Struct.new(:email).new(fake_emails)
    OrderMailer.place_orders(Order.today, fake_delivery).deliver
    puts "done."
  end
