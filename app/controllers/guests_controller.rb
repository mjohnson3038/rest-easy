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

  # def create
  #   @new_guest = Guest.new(guest_params)
  #   if @new_guest.save
  #     receipt_id = Guest.find(@new_guest.id).receipt_id
  #     puts ">>>>>>>" + receipt_id.to_s
  #     redirect_to receipt_guests_path(receipt_id: receipt_id)
  #   else
  #     redirect_to root_path
  #   end
  # end

  def split

  end

  private

  def guest_params
    params.require(:guest).permit(:name, :phone, :receipt_id)
  end
end
