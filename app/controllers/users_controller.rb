class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def show
    @items = @user.items
  end

  def update
    if @user.update(update_params)
      redirect_to :show
    end
  end

  private

  def update_params
    params.require(:user).permit(:profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end