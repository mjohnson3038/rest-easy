require 'rtesseract'

class ReceiptsController < ApplicationController
respond_to :html, :js

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

  def show
    if @user == nil
      redirect_to login_failure_path
    elsif @user.id != Receipt.find(params[:id]).user_id
      puts ">>>>>>>>>>>>>>" + @user.id.to_s
      redirect_to root_path, notice: "You are not logged in as the owner of this receipt"
    elsif @user.id == Receipt.find(params[:id]).user_id
      # puts ">>>>>>>>>>>>>>" + @user.id.to_s
      @receipt = Receipt.find(params[:id])

      # To display the associated list_items with the receipt instead of just the text from the receipt.
      @items_per_receipt = ListItem.where(receipt_id: @receipt.id)
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

      redirect_to receipts_path, notice: "The receipt has been uploaded"
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

private
  def receipt_params
    params.require(:receipt).permit(:name, :attachment)
  end

  def check_user

  end
end
