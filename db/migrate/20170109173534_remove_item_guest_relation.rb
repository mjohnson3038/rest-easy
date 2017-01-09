class RemoveItemGuestRelation < ActiveRecord::Migration[5.0]
  def change
    remove_column :list_items, :guest_id
  end
end
