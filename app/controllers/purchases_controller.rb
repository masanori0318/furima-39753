class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :sold
  before_action :items_user

  def index
    @purchase_address = PurchaseAddress.new
  end

  def creste
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city_id, :house_number, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def sold
    @item = Item.find(params[:item_id])
    if @item.purchase.present?
      redirect_to root_path
    end
  end

  def items_user
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end
end
