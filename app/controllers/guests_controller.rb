# TODO be able to unclick the items people ordered.

class GuestsController < ApplicationController

  # def index
  #   # @params = params[:]
  #   @receipt = Receipt.find(params[:receipt_id])
  #   @guests_per_receipt = Guest.where(receipt_id: @receipt.id)
  # end
  #
  # def new
  #
  #   @receipt = Receipt.find(params[:receipt_id])
  #
  #   # If this is the first guest that is created, then the status needs to change so that the receipt is no longer editable. Additionally, all of the guest_items must be generated.
  #   puts "receipt status ++++++" + @receipt.status.to_s
  #
  #   # Once that has been completed, create the guest as expected. This is the only thing the user can see.
  #   @new_guest = Guest.new
  #   @name = :name
  #   @phone = :phone
  # end
  #
  # def create
  #   @new_guest = Guest.new(guest_params)
  #   if @new_guest.save
  #     # receipt_id = Guest.find(@new_guest.id).receipt_id
  #     # puts ">>>>>>>" + receipt_id.to_s
  #     redirect_to receipt_guest_guest_items_path(receipt_id: params[:receipt_id], guest_id: @new_guest.id)
  #   else
  #     redirect_to root_path
  #   end
  # end
  # #
  # # def show
  # #   # receipt_id = params[:receipt_id]
  # #   @guest_id = params[:id]
  # #
  # #   @guest_items = GuestItem.where(guest_id: @guest_id)
  # # end
  #
  # def show
  #   @current_guest_id = params[:id]
  #   @guest_items = GuestItem.where(guest_id: @current_guest_id)
  #
  #   total = 0
  #   @guest_items.each do |item|
  #     total += item.price
  #   end
  #   @total = total
  #   tax = 9.6 * 0.01
  #   @tax = total * tax
  #
  #   @guest = Guest.find(@current_guest_id)
  #   # TODO - why isn't the total method working?
  #   # @min = (@current_guest.total()) * 0.15
  #   # @max = @current_guest.total()
  # end
  #
  # def add_tip
  #   puts ">>>>>>>>>>>>" + params.to_s
  #   current_guest = Guest.find(params[:guest_id])
  #   current_guest.tip = params[:tip]
  #   current_guest.save
  #   receipt_id = current_guest.receipt_id
  #   redirect_to receipt_guest_guest_items_path(receipt_id: receipt_id, guest_id: params[:guest_id])
  #   # TODO - add a flash message thanking the guest, and naming the total
  #   # TODO - use ajax to toal tip, items, and tax
  #   # TODO remove Guest#new form and from the controller and the route, handled by AJAX in teh GUEST ITems controller, ask Kari if this is okay.
  # end
  #
  # private
  #
  # def guest_params
  #   params.require(:guest).permit(:name, :phone, :receipt_id)
  # end
end
