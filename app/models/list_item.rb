class ListItem < ApplicationRecord
  belongs_to :receipt
  has_many :guest_items

end
