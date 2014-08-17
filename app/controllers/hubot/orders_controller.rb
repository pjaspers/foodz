class Hubot::OrdersController < ApplicationController
  before_filter :ensure_json
  protect_from_forgery with: :null_session

  def index
    # ISO 8601 format: YYYY-MM-DD
    # or shorthand today
    if date = ordered_on
      render json: Order.not_cancelled.ordered_on(date)
    else
      render json: Order.not_cancelled
    end
  end

  def create
    if order_params[:delete] && order_params[:delete] == "X"
      delete_order
      render json: "Deleted"
    else
      order = create_order_with_username_metadata(order_params[:username], order_params[:metadata])
      render json: order
    end
  end

  def mail
    fake_delivery = Struct.new(:email).new(fake_emails)
    OrderMailer.place_orders(Order.today, fake_delivery).deliver
    render json: "Mail sent"
  end

  protected

  def fake_emails
    Rails.application.secrets.fake_delivery_emails.split(",").collect(&:strip)
  end

  def ensure_json
    request.format = :json
  end

  def ordered_on
    return Date.today.strftime("%Y-%m-%d") unless params[:ordered_on]

    Date.strptime(params[:ordered_on], '%Y-%m-%d') rescue nil
  end

  def create_order_with_username_metadata(username, metadata)
    order = Order.today.find_or_create_by(username: username)
    order.metadata = metadata
    order.cancelled_at = nil
    order.save
  end

  def delete_order
    if params[:all_users] && params[:all_users] == "X"
      delete_all_orders_for_today
    elsif params[:username]
      delete_order_with_username
    end
  end

  def delete_all_orders_for_today
    Order.today.update_all(cancelled_at: Time.now)
  end

  def delete_order_with_username
    if order = Order.today.find_by(username: order_params[:username])
      order.update_attributes(cancelled_at: Time.now)
    end
  end

  def order_params
    params.permit("delete", "metadata", "username", :metadata, :all_users)
  end

end
