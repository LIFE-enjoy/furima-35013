class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_root

  def index
    @order_record_order = OrderRecordOrder.new
  end

  def create
    @order_record_order = OrderRecordOrder.new(order_params)
    if @order_record_order.valid?
      pay_item
      @order_record_order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    params.require(:order_record_order).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_root
    redirect_to root_path if current_user.id == @item.user_id
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end
end
