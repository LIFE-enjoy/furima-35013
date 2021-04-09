class OrderRecordsController < ApplicationController
  def index
    @order_record = OrderRecord.where(user_id: current_user.id).order('created_at DESC')

  end
end
