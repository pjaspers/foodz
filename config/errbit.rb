Airbrake.configure do |config|
  config.api_key = '8f98c6e44a7e77f76ba06764c640b85e'
  config.host    = 'errbit-10to1.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end
