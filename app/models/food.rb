class Food < ActiveRecord::Base
  belongs_to :delivery
  has_many :lines
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :categories
end
