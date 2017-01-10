class GuestBelongToReceipt < ActiveRecord::Migration[5.0]
  def change
    add_reference :guests, :receipt, foreign_key: true
  end
end
