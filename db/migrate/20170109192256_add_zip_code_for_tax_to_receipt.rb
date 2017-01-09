class AddZipCodeForTaxToReceipt < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :zip_code, :string
  end
end
