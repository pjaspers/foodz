class Hubot::FoodController < ApplicationController
  def index
    render json: Food.all.to_json
  end
end
