class Hubot::UsersController < ApplicationController
  def sandwichless
    render json: User.users_without_orders.to_json
  end
end
