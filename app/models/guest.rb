class Guest < ApplicationRecord
  belongs_to :receipt

  # def total
  #   guest_items = GuestItem.where(guest_id: self.id)
  #
  #   total = 0
  #   guest_items.each do |item|
  #     total += item.price
  #   end
  #   return total
  # end
end
