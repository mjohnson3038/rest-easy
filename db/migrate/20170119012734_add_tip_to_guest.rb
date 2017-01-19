class AddTipToGuest < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :tip, :decimal
  end
end
