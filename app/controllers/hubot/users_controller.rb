class Hubot::UsersController < ApplicationController
  def sandwichless
    render json: Order.sandwichless_usernames.to_json
  end
end
