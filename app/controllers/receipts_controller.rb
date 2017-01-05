require 'rtesseract'

class ReceiptsController < ApplicationController

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
      @receipt = Receipt.new(user_id: @user)
    end
  end

  def show
    if @user == nil
      redirect_to login_failure_path
    elsif @user.id != Receipt.find(params[:id]).user_id
      puts ">>>>>>>>>>>>>>" + @user.id.to_s
      redirect_to root_path, notice: "You are not logged in as the owner of this receipt"
    elsif @user.id == Receipt.find(params[:id]).user_id
      puts ">>>>>>>>>>>>>>" + @user.id.to_s
      @receipt = Receipt.find(params[:id])

      file = @receipt.attachment.file.file

      image = RTesseract.new(file)

      @text = image.to_s

      @split = @text.split("\n")
    end
  end

  def create
    @receipt = Receipt.new(receipt_params)

    if @receipt.save
      redirect_to receipts_path, notice: "The receipt has been uploaded"
    else
      render "new"
    end
  end

  def destroy
    check_user
    if @user == nil
      redirect_to login_failure_path
    else
      @receipt = Receipt.find(params[:id])
      @receipt.destroy
      redirect_to receipts_path, notice:  "The receipt #{@receipt.name} has been deleted."
    end
  end

private
  def receipt_params
    params.require(:receipt).permit(:name, :attachment)
  end

  def check_user
    if @user == nil
      flash[:notice] = "You need to log in to edit this."
      redirect_to root_path
    elsif @user != Receipt.find(params[:id]).user_id
      flash[:notice] = "This is not your receipt, you can't delete it"
      redirect to root_path
    end
  end
end
