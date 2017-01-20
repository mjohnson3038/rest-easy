# require 'rtesseract'

class ReceiptsController < ApplicationController
# respond_to :html, :js

  def index
    if @user == nil
      redirect_to login_failure_path
    else
      @receipts = Receipt.where(user_id: @user.id)
    end
  end

  def new
    if @user == nil
      redirect_to login_failure_path
    else
      @receipt = Receipt.new
    end
  end

  def create
    # Calls user method in the application_controller
    user
    @current_user = User.find(@user.id)

    @receipt = @current_user.receipts.new(receipt_params)

    if @receipt.save

      # Once the receipt has been saved/registered then it should automatically also create all the list items associated with the receipt.
      @receipt.process()

      # IF THE RECEIPT WAS SAVED, create the first guest of the receipt, ie the user

      Guest.create!(name: @user.name, receipt_id: @receipt.id)

      redirect_to receipt_list_items_path(receipt_id: @receipt.id), notice: "The receipt has been uploaded"
    else
      render "new"
    end
  end

  def destroy
    if @user.id == nil
      flash[:notice] = "You need to log in to edit this."
      redirect_to root_path
    elsif @user.id != Receipt.find(params[:id]).user_id
      flash[:notice] = "This is not your receipt, you can't delete it"
      redirect_to root_path
    elsif @user.id == Receipt.find(params[:id]).user_id
      @receipt = Receipt.find(params[:id])
      @receipt.destroy
      redirect_to receipts_path
    end
  end

  def finalize
    # potentially make this a post action to change the status of the receipt and redisplay one of the previous pages, but changes.

    @receipt = params[:receipt_id]
    @guests_per_receipt = Guest.where(receipt_id: @receipt)
    @list_items = ListItem.where(receipt_id: @receipt)
    # potentially move to the model.
    @receipt_tip = 0.0
    # Go through the list of guests associated with the receipt and add the tips together.
    @guests_per_receipt.each do |person|
      if person.tip != nil
        @receipt_tip += person.tip
      end
    end

    # Go through the list of items and sum them together to get the total and tax on the receipt.
    @total = 0
    @list_items.each do |item|
      @total += item.price
    end
  end

private
  def receipt_params
    params.require(:receipt).permit(:name, :attachment, :zip_code, :status)
  end

  def check_user

  end
end
