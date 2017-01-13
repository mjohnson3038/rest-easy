require 'rtesseract'

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

  # TO change the status and also to create the guest items before transitioning into creating the guests
  def split

  end

private
  def receipt_params
    params.require(:receipt).permit(:name, :attachment, :zip_code, :status)
  end

  def check_user

  end
end
