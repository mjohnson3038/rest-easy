class ListItemsController < ApplicationController

  def edit
    # ADD CHECKING FOR USER
    @list_item = ListItem.find(params[:id])
    @quantity = :quantity
    @description = :description
    @price = :price

  end

  def update
    @this_item = ListItem.find(params[:id])
    # To identify which receipt needs to be updated
    receipt_id = ListItem.find(params[:id]).receipt_id

    if @this_item.update(list_item_params)
      puts "EDIzttttss >>>>>>>>>>>>"
      redirect_to receipt_path(receipt_id)
    else
      render :edit
    end
  end

  def new
    @new_item = ListItem.new
    @quantity = :quantity
    @description = :description
    @price = :price
  end

  def create
    puts ">>>>>>>>>>" + list_item_params.to_s
    parameters[:list_item]
    @new_item = ListItem.new(list_item_params)
    if @new_item.save
      # QUESTION - should be redirecting back to the receipt page, but how can I grab hold of the receipt id?
      redirect_to receipts_path
    else
      redirect_to root_path
    end
  end

  def destroy
    receipt_id = ListItem.find(params[:id]).receipt_id
    @item = ListItem.find(params[:id]).destroy
    redirect_to list_item_path(receipt_id)
  end

  private

  def list_item_params
    params.require(:list_item).permit(:quantity, :description, :price, :receipt_id)
  end
end
