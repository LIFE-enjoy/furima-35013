class OrderRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_root
  
  def index
    @order_record = OrderRecord.where(user_id: current_user.id).order('created_at DESC')
  end

  private
  def redirect_root
    @user = User.find(params[:user_id])
    redirect_to root_path if current_user.id != @user.id
  end
end
