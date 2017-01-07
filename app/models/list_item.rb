class ListItem < ApplicationRecord
  belongs_to :guest
  belongs_to :receipt

end
