class Guest < ApplicationRecord
  has_many :guest_items
  belongs_to :receipt
end
