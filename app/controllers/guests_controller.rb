class GuestsController < ApplicationController
  def index
    # @params = params[:]
    @receipt = Receipt.find(params[:receipt_id])
    @guests_per_receipt = Guest.where(receipt_id: @receipt.id)
  end

  def new
    @new_guest = Guest.new
    @name = :name
    @phone = :phone
  end

  def create
    @new_guest = Guest.new(guest_params)
    if @new_guest.save
      # receipt_id = Guest.find(@new_guest.id).receipt_id
      # puts ">>>>>>>" + receipt_id.to_s
      redirect_to split_receipt_path(id: @new_guest.id)
    else
      redirect_to root_path
    end
  end

  def show
    # receipt_id = params[:receipt_id]
    @guest_id = params[:id]

    @guest_items = GuestItem.where(guest_id: @guest_id)
  end

  def split
    # TO identify the current guest selecting the boxes
    @current_guest = Guest.find(params[:id])

    @current_receipt = Receipt.find(@current_guest.receipt_id)

    @list_items = ListItem.where(receipt_id: @current_receipt)

  end

  private

  def guest_params
    params.require(:guest).permit(:name, :phone, :receipt_id)
  end
end
