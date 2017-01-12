class AddEditableStatusToReceipt < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :status, :integer
  end
end
