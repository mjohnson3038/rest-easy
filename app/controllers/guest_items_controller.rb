class GuestItemsController < ApplicationController
  def create
    puts ">>>>>>>>> BEING CREATED GUEST ITEM!!!!!!!!!!"
    @new_guest_item = GuestItem.new(guest_item_params)
    if @new_guest_item.save
      redirect_to receipts_path
    else
      redirect_to root_path
    end
  end

  def index
    # Only need to display the items which are unclaimed OR Belong to the guest already
    @guest_id = params[:guest_id]

    @receipt_id = params[:receipt_id]

    @guest_items = GuestItem.includes(:list_item).where(list_items: {receipt_id: @receipt_id})

    @current_guest = Guest.find(params[:guest_id])

    @receipt_guests = Guest.where(receipt_id: @receipt_id)
  end

  def guest_item_params
    params.require(:guest_item).permit(:price, :receipt_id)
  end

  def update
    # Id's that were checked come in an array of strings. Go through the array and update all the receipt items with the given guest's id.
    params[:item_ids].each do |id|
      update = GuestItem.find(id.to_i)
      update.guest_id = params[:guest_id]
      update.save
    end
    redirect_to root_path

  end

end
