class GuestItemhasGuestId < ActiveRecord::Migration[5.0]
  def change
    add_column :guest_items, :guest_id, :integer
  end
end
