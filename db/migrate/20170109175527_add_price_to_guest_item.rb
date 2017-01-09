class AddPriceToGuestItem < ActiveRecord::Migration[5.0]
  def change
    add_column :guest_items, :price, :integer
  end
end
