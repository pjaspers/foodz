class Order < ActiveRecord::Base
  has_many :lines

  scope :today, -> {where("created_at >= ? AND created_at < ?", Time.now.beginning_of_day, Time.now.end_of_day)}
  scope :ordered_on, ->(date) {where("created_at >= ? AND created_at < ?", date.to_time.beginning_of_day, date.to_time.end_of_day)}
end
