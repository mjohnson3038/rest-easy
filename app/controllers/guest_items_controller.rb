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

    @receipt_id = params[:receipt_id]

    @guest_items = GuestItem.includes(:list_item).where(list_items: {receipt_id: @receipt_id})

    @current_guest = Guest.find(params[:guest_id])
  end

  def guest_item_params
    params.require(:guest_item).permit(:price, :receipt_id)
  end

end
