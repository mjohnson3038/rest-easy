class GuestItem < ApplicationRecord
  belongs_to :list_item
  belongs_to :guest
end
