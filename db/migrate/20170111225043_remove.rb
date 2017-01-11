class Remove < ActiveRecord::Migration[5.0]
  def change
    remove_column :guest_items, :guest_id
  end
end
