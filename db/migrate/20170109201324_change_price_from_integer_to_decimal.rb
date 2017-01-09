class ChangePriceFromIntegerToDecimal < ActiveRecord::Migration[5.0]
  def change

    remove_column :list_items, :price, :integer
    add_column :list_items, :price, :float

    remove_column :guest_items, :price, :integer
    add_column :guest_items, :price, :float
  end
end
