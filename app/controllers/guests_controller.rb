class GuestsController < ApplicationController

  def new
    @new_guest = Guest.new
    @name = :name
    @phone = :phone
  end

  def create
    @new_guest = Guest.new(guest_params)
    if @new_guest.save
      receipt_id = Guest.find(@new_guest.id).receipt_id
      puts ">>>>>>>" + receipt_id.to_s
      redirect_to receipt_list_items_path(receipt_id: receipt_id)
    else
      redirect_to root_path
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :phone, :receipt_id)
  end
end
