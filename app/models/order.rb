class Order < ActiveRecord::Base
  has_many :lines
end
