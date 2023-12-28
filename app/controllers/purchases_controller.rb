class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create]
  before_action :items_user
  before_action :sold
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_address = PurchaseAddress.new
  end

  def create
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item(@purchase_address.token)
      @purchase_address.save
      redirect_to root_path, turbolinks: true
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    @item = Item.find(params[:item_id]) # この行を追加
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city_id, :house_number, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def items_user
    @item = Item.find(params[:item_id])
    

    if user_signed_in? && @item.user.present? && current_user.id != @item.user.id
      return unless current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def sold
    @item = Item.find(params[:item_id])
    return unless @item.purchase.present?

    redirect_to root_path
  end

  def pay_item(_amount)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end
end
