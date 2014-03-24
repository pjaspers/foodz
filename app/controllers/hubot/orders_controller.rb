class Hubot::OrdersController < ApplicationController

  def index
    # ISO 8601 format: YYYY-MM-DD
    # or shorthand today
    if date = ordered_on
      render json: Order.ordered_on(date)
    else
      render json: Order.all
    end
  end

  def create
    return render json: "No username found" unless order_params[:username]

    if order_params[:delete] && order_params[:delete] == "X"
      delete_order_with_username
      render json: "Deleted"
    else
      order = create_order_with_username_metadata(order_params[:username], order_params[:metadata])
      render json: order
    end
  end

  protected

  def ordered_on
    return unless params[:ordered_on]
    return Date.today.strftime("%Y-%m-%d")

    Date.strptime(params[:ordered_on], '%Y-%m-%d') rescue nil
  end

  def create_order_with_username_metadata(username, metadata)
    order = Order.today.find_or_create_by(username: username)
    order.metadata = metadata
    order.save
  end

  def delete_order_with_username
    if order = Order.today.find_by(username: order_params[:username])
      order.destroy
    end
  end

  def order_params
    params.require(:username)
    params.permit(:delete, :metadata, :username, :metadata)
  end

end
