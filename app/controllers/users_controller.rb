class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def show
    @items = @user.items
  end

  def update
    redirect_to :show if @user.update(update_params)
  end

  private

  def update_params
    params.require(:user).permit(:profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
