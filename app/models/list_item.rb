class ListItem < ApplicationRecord
  belongs_to :receipt
  has_many :guest_items
  #
  # def process
  #   puts ">>>>>>>> YES THE RECEipt WAS PROCESSED!!!!"
  #   puts self.id
  #
  #   # line_occurances = self.quantity
  #   # price_per_item = (self.price / self.quantity).to_f
  #   #
  #   # # To create the given number of lines (based on the quantity)
  #   # line_occurances.times do
  #   #   self.guest_items.create!(receipt_id: self.receipt_id, price: price_per_item)
  #   # end
  #
  #   # self.guest_items.create!(list_item_id: 98, price: 999.99, guest_id: 5)
  # end

end
