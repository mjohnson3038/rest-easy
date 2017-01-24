class AddTaxToSchemaSoDontLookUpEachTime < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :tax, :decimal
  end
end
