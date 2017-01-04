class CreateListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :list_items do |t|
      t.belongs_to :receipt, index: true
      t.belongs_to :guest
      t.string :description
      t.integer :price
      t.integer :portion

      t.timestamps
    end
  end
end
