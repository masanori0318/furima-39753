class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :items_user
  before_action :sold

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      if @purchase_address.save
        redirect_to root_path, turbolinks: true 
      else
      #flash.now[:alert] = @purchase_address.errors.full_messages.join(', ')
        puts @purchase_address.errors.full_messages
        render :index, status: :unprocessable_entity 
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city_id, :house_number, :building, :phone_number, :token).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def items_user
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def sold
    @item = Item.find(params[:item_id])
    if @item.purchase.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
   params.require(:order).permit(:price)
  end
end
