class Order < ActiveRecord::Base
  has_many :lines

  scope :ordered_on, ->(date) {where("created_at >= ? AND created_at < ?", date.to_time.beginning_of_day, date.to_time.end_of_day)}

  scope :today, -> { ordered_on(Date.today.strftime("%Y-%m-%d")) }

  scope :ordered_since, -> (date) { where("created_at >= ?", date.to_time.beginning_of_day) }

  def self.active_usernames(date: 3.days.ago)
    ordered_since(date).distinct.pluck(:username)
  end

  def self.ordered_usernames(date: Date.today)
    ordered_on(date).distinct.pluck(:username)
  end

  def self.sandwichless_usernames
    active_usernames - ordered_usernames
  end

end
