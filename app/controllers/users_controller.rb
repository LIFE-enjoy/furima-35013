class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def show
    @items = @user.items
    @order_record = OrderRecord.all
  end

  def update
    @user.update(update_params)
    redirect_to action: :show
    return
  end

  private

  def update_params
    params.require(:user).permit(:profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
