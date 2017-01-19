class AddTotalPerGuest < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :item_total, :decimal
  end
end
