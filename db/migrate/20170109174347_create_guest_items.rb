class CreateGuestItems < ActiveRecord::Migration[5.0]
  def change
    create_table :guest_items do |t|
      t.belongs_to :list_item, index: true
      t.belongs_to :guest, index: true
      # To add in the future the option of spliting a meal
      t.integer :meal_percentage

      t.timestamps null: false
    end
  end
end
