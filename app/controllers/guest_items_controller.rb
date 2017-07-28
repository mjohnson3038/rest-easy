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

    # This is only called the first time you go to guest_items#index because the status changes within the method change_to_splittable. Bug occured because no longer going through the guest#new page.

    @receipt = Receipt.find(@receipt_id)
    if @receipt.status < 2
      # Calls method to generate the guest methods and to change the status.
      @receipt.change_to_splittable()
    end

    # DEBUGGING - guestItems are not appearing - are they being generated? - GuestItems are generated when you click "Let's begin splitting"

    @guest_items = GuestItem.includes(:list_item).where(list_items: {receipt_id: @receipt_id})

    @current_guest = Guest.find(params[:guest_id])

    # TODO - make the list of guests displayed to NOT include the current_guest
    @receipt_guests = Guest.where(receipt_id: @receipt_id)

    # FOR THE AJAX OF ADDING A NEW USER
    @new_guest = Guest.new

    # Do all items have a guest? If so then you should be able to finalize the receipt

  end

  def update
    # Id's that were checked come in an array of strings. Go through the array and update all the receipt items with the given guest's id. Additionally, needs to add the price of the item to the guests total.
    guest = Guest.find(params[:guest_id])
    # the item_total is 0 whenever this starts or else when the button is ever pressed more than once for an item it goes to that person.
    guest.item_total = 0

    # Additionally, all items with the guest_id of the person who submits, should be nil just in case they unchecked anything. Therefore, iterate through a list of guest_items with that guest_id and nil them out. Then the will get checked off again.

    @guest_items = GuestItem.where(guest_id: params[:guest_id])
    @guest_items.each do |item|
      item.guest_id = nil
      item.save
    end

    # Will get an error if nil, so this acts as a barrier for that.
    if params[:item_ids] != nil
      # May only select uclaimed items. Needs to be checked before submitting the rest.
      params[:item_ids].each do |id|
        check = GuestItem.find(id.to_i)
        if check.guest_id != nil
          # redirect_to receipt_guest_guest_items_path(receipt_id: params[receipt_id])
          flash[:error] = "NOTICE: You may only claim items not already claimed, to delete an item, pick a user and resubmit their order"
          receipt = Receipt.find(guest.receipt_id)

          puts "receipt_id: >>>>>>>>" + params[:receipt_id].to_s
          redirect_to receipt_guest_guest_items_path(receipt_id: receipt.id, guest_id: params[:guest_id])
          return
        end
      end



      # Iterating through the guest_items that were checked off. They are sent view an array as strings
      params[:item_ids].each do |id|

        # setting the guest_id on those items.
        update = GuestItem.find(id.to_i)
        update.guest_id = params[:guest_id]
        update.save
        # Adding the total of those items to the guest total.

        guest.item_total = guest.item_total + ListItem.find(update.list_item_id).price
        guest.save
      end
    end



    puts ">>>>>>" + params.to_s
    # redirect_to root_path
    redirect_to receipt_guest_path(receipt_id: Guest.find(params[:guest_id]).receipt_id, id: params[:guest_id])
  end

  def create_guest
    @new_guest = Guest.new(params[:guest])

    respond_to do |format|
      if @new_guest.save
        format.html {redirect_to @new_guest, notice: "Guest was successfully created"}
        format.js
        format.json{ render json: @new_guest, status: :created, location: @new_guest}
      else
        format.html { render action: "new" }
        format.json { render json: @new_guest.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def guest_item_params
    params.require(:guest_item).permit(:price, :receipt_id)
  end
end
