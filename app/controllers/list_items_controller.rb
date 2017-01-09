class ListItemsController < ApplicationController

  def edit
    # ADD CHECKING FOR USER
    @list_item = ListItem.find(params[:id])

  end

  def update

  end

  def create
    # @item = ListItem.new(list_item_params)
    #
    # if @item.save
    #   redirect_to root_path
    # else
    #   render new_receipt_path
    # end
  end
end
