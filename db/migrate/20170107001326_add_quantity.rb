class AddQuantity < ActiveRecord::Migration[5.0]
  def change
    add_column :list_items, :quantity, :integer
  end
end
