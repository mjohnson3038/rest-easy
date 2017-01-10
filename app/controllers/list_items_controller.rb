class ListItemsController < ApplicationController

  def index
    if @user == nil
      redirect_to login_failure_path
    elsif @user.id != Receipt.find(params[:receipt_id]).user_id
      puts ">>>>>>>>>>>>>>" + @user.id.to_s
      redirect_to root_path, notice: "You are not logged in as the owner of this receipt"
    elsif @user.id == Receipt.find(params[:receipt_id]).user_id
      # puts ">>>>>>>>>>>>>>" + @user.id.to_s
      @receipt = Receipt.find(params[:receipt_id])

      # To display the associated list_items with the receipt instead of just the text from the receipt.
      @items_per_receipt = ListItem.where(receipt_id: @receipt.id)
    end
  end

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
      redirect_to receipt_list_items_path(receipt_id)
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
    @new_item = ListItem.new(list_item_params)
    if @new_item.save

      receipt_id = ListItem.find(@new_item.id).receipt_id
      puts ">>>>>>>" + receipt_id.to_s
      redirect_to receipt_path(receipt_id)
    else
      redirect_to root_path
    end
  end

  def destroy
    receipt_id = params[:receipt_id]
    @item = ListItem.find(params[:id]).destroy
    redirect_to receipt_list_items_path(receipt_id)
  end

  private

  def list_item_params
    params.require(:list_item).permit(:quantity, :description, :price, :receipt_id)
  end
end
