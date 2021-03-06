class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item_shop = ItemShop.find(params[:id])
  end

  def create
    @item_shop = ItemShop.find(params[:id])
    item = @item_shop.items.create!(item_params)
    item.save
    redirect_to "/item_shops/#{@item_shop.id}/items"
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to "/items/#{@item.id}"
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.permit(:name, :quantity, :price, :consumable)
  end
end
