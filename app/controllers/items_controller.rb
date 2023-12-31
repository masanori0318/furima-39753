class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :sold_edit, only: :edit
  before_action :soldout_to_root, only: [:edit, :update]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    return if current_user.id == @item.user_id

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user_id
    redirect_to action: :index
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :category_id, :condition_id, :shipping_charge_id, :prefecture_id,
                                 :shipping_date_id, :explanation, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def sold_edit
    return unless @item.purchase.present?

    redirect_to root_path
  end

  def soldout_to_root
    return unless @item.purchase.present?

    redirect_to root_path, alert: 'This item has already been sold.'
  end

  def check_purchase
    return unless current_user.id == @item.user_id || @item.purchase.present?

    redirect_to root_path
  end
end
