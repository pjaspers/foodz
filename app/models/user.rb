class User
    Order.ordered_since(date).distinct.pluck(:username)
  def self.active_usernames(date: 5.days.ago)
  end

  def self.ordered_usernames(date: Date.today)
    Order.ordered_on(date).distinct.pluck(:username)
  end

  def self.users_without_orders
    active_usernames - ordered_usernames
  end

end
