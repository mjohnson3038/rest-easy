class ListItemsController < ApplicationController

  def create
    @item = ListItem.new(list_item_params)

    if @item.save
      redirect_to root_path
    else
      render new_receipt_path
    end 
  end
end
