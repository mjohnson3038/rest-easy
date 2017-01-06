class ListItemsController < ApplicationController
  def process

    if @user == nil
      redirect_to login_failure_path
    elsif @user.id != Receipt.find(params[:id]).user_id
      puts ">>>>>>>>>>>>>>" + @user.id.to_s
      redirect_to root_path, notice: "You are not logged in as the owner of this receipt"
    elsif @user.id == Receipt.find(params[:id]).user_id

      ListItem.process(params[:id])
  
    end
  end
end
