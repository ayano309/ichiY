class Dashboard::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: %w[show edit update destroy]
  layout "dashboard/dashboard"

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to dashboard_items_path
  end

  def edit
    
  end

  def update
    @item.update(item_params)
    redirect_to dashboard_items_path
  end

  def destroy
    @item.destroy
    redirect_to dashboard_items_path
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :price, :image)
    end
end
