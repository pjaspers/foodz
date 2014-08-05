class User
  def self.active_usernames(date: 3.days.ago)
    Order.ordered_since(date).distinct.pluck(:username)
  end

  def self.ordered_usernames(date: Date.today)
    Order.ordered_on(date).distinct.pluck(:username)
  end

  def self.users_without_orders
    active_usernames - ordered_usernames
  end

end
