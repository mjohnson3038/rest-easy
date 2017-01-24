# require 'rtesseract'

# require 'carrierwave/orm/activerecord'

class Receipt < ActiveRecord::Base
  belongs_to :user
  has_many :list_items
  has_many :guests

  validates :user, :presence => true


  # validates the presence of status, between 1(editable),2(splitable),3(completed)
  validates :status, presence: true, :numericality => {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3}

  def process
    # Add in tax
    self.tax = AvalaraApiWrapper.sales_tax(self.zip_code)
    self.save

    # Turns image into an array of text strings which.

    file = self.attachment.file.file
    image = RTesseract.new(file)

    @split = image.to_s.split("\n")
    # @split = ["hashd", "asdads", "$2.30"]

    @split.each do |line|
      # # Go through each line and in each line, check that the last thing is a float, the item directly before the float OR the first item is a single integer, and then it also contains some kind of aphabetical text" If all this is true, then it is a true line item in the receipt, all other receipt lines will be ignored.
      examine_line = line.split(" ")

      # Last element, check to see if it is a float - need to remove the "$" before checking

      if examine_line.length !=0 && examine_line.last.gsub("$", "").to_f != 0.0
        puts "NEW LINE"

        # A line item will only be made if a price is present. The price is the only thing that needs to be present to create the item. A price is always the last thing in the line. It should also always be a float. Once the "$" symbol is removed it should always be a float. It is not a float if when you attempt to make it into a float it turns to 0. Additionally, this is convienient because items that are free on the receipt, do not need to be accounted for and do not need to be selected by a guest.


        # To select the price in the line. NOTE Price is multiplied by 100 here, to save the digits, and then will be divided by 100 in the list_item view and whenever it is used on other models.
        price = examine_line.last.gsub("$", "").to_f

        # To select the quantity

        # OCR often reads 1 as I => including that case to identify the quantity. Also when the item is not a number (ie a letter), when you turn it into a number, it become 0. Since a quantity will never be 0, or else it wouldn't be on the receipt => so long as it is >0, it is a number and we can peg this as the quantity.

        if examine_line.first == "I" || examine_line.first.to_i > 0
          if examine_line.first == "I"
            quantity = 1
            examine_line.delete_at(0)
          else
            quantity = examine_line.first.to_i
            examine_line.delete_at(0)
          end
        end

        if examine_line[-2] == "I" || examine_line[-2].to_i > 0
          if examine_line[-2] == "I"
            quantity = 1
            examine_line.delete_at(-2)
          else
            quantity = examine_line[-2].to_i
            examine_line.delete_at(-2)
          end
        end

        # If the quantity is not registered, it is 1
        quantity ||= 1


        # To select the name/description of the item.
        examine_line.pop
        name = examine_line.join(" ")

        puts "quantity >>>>" + quantity.to_s
        puts "name >>>>" + name.to_s
        puts "price >>>>" + price.to_s


        self.list_items.create!({description: name, price: price, quantity: quantity})

      end
    end
  end

  # TODO - why is this method not working? Written in the controller, but ideally would be here.
  def change_to_splittable()
    puts "YOU HAVE ENTERED THE RECEIPT MODEL! and are about to make all the guest_items assocaited with this receipt"

    puts self
    puts "the id of the receipt is: " + self.id.to_s

    list_items = ListItem.where(receipt_id: self.id)

    # Going through the ListItems associated with the receipt, making guest_items with the number of quantity, and the price divided if the quantity > 1.
    list_items.each do |item|
      item.quantity.times do
        GuestItem.create!(list_item_id: item.id, price: (item.price/item.quantity))
        puts item.price
        puts item.quantity
        puts GuestItem.last.price
      end
    end

    # AND NOW, change the status since all the guestItems have been made.
    receipt = self
    receipt.status = 2
    receipt.save

    puts ">>>>>>>>>>>>>>>>receipt status" + receipt.status.to_s
  end


  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.

end
