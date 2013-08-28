class ItemsController < ApplicationController
  respond_to :json

  def index
  end

  def create
    @item = Item.create(params[:item])
    respond_with(@item)
  end

  def show
  end

  def update
  end
end
