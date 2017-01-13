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

    # TODO - make the list of guests displayed to NOT include the current_guest
    @receipt_guests = Guest.where(receipt_id: @receipt_id)
  end

  def update
    # Id's that were checked come in an array of strings. Go through the array and update all the receipt items with the given guest's id.
    if params[:item_ids] != nil
      params[:item_ids].each do |id|
        update = GuestItem.find(id.to_i)
        update.guest_id = params[:guest_id]
        update.save
      end
    end
    # redirect_to root_path
    redirect_to guests_tip_path(params[:guest_id])
  end

  private

  def guest_item_params
    params.require(:guest_item).permit(:price, :receipt_id)
  end
end
