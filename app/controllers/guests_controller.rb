class GuestsController < ApplicationController
  def index
    # @params = params[:]
    @receipt = Receipt.find(params[:receipt_id])
    @guests_per_receipt = Guest.where(receipt_id: @receipt.id)
  end

  def new

    @receipt = Receipt.find(params[:receipt_id])

    # If this is the first guest that is created, then the status needs to change so that the receipt is no longer editable. Additionally, all of the guest_items must be generated.
    puts "receipt status ++++++" + @receipt.status.to_s

    if @receipt.status != 2
      # Calls method to generate the guest methods and to change the status.
      @receipt.change_to_splittable()
    end

    # Once that has been completed, create the guest as expected. This is the only thing the user can see.
    @new_guest = Guest.new
    @name = :name
    @phone = :phone
  end

  def create
    @new_guest = Guest.new(guest_params)
    if @new_guest.save
      # receipt_id = Guest.find(@new_guest.id).receipt_id
      # puts ">>>>>>>" + receipt_id.to_s
      redirect_to receipt_guest_guest_items_path(receipt_id: params[:receipt_id], guest_id: @new_guest.id)
    else
      redirect_to root_path
    end
  end

  def show
    # receipt_id = params[:receipt_id]
    @guest_id = params[:id]

    @guest_items = GuestItem.where(guest_id: @guest_id)
  end

  # def split
  #   # TO identify the current guest selecting the boxes
  #   @current_guest = Guest.find(params[:id])
  #
  #   @current_receipt = Receipt.find(@current_guest.receipt_id)
  #
  #   @list_items = ListItem.where(receipt_id: @current_receipt)
  #
  # end

  private

  def guest_params
    params.require(:guest).permit(:name, :phone, :receipt_id)
  end
end
