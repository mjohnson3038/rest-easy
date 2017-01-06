require 'rTesseract'

# require 'carrierwave/orm/activerecord'

class Receipt < ActiveRecord::Base
  belongs_to :user
  has_many :list_items

  # Tests to see if something within a string is actually an integer/fixnum
  def is_i?
     /\A[-+]?\d+\z/ === self
  end

  # Test to see if a string contains character letters
  def contains_letters?
    if self.match(/[a-zA-Z]/i)
      return true
    else
      return false
    end
  end

  def process
    # Turns image into an array of text strings which.
    file = self.attachment.file.file
    image = RTesseract.new(file)
    @split = image.to_s.split("\n")

    @split.each do |line|
      # # Go through each line and in each line, check that the last thing is a float, the item directly before the float OR the first item is a single integer, and then it also contains some kind of aphabetical text" If all this is true, then it is a true line item in the receipt, all other receipt lines will be ignored.
      examine_line = line.split(" ")

      # Last element, check to see if it is a float - need to remove the "$" before checking

      if examine_line.length !=0
        puts "NEW LINE"

        # OCR often reads 1 as I => including that case to identify the quantity. Also when the item is not a number (ie a letter), when you turn it into a number, it become 0. Since a quantity will never be 0, or else it wouldn't be on the receipt => so long as it is >0, it is a number and we can peg this as the quantity.

        if examine_line.first == "I" || examine_line.first.to_i > 0
          if examine_line.first == "I"
            quantity = 1
            puts "quantity >>>>>" + quantity.to_s
          else
            quantity = examine_line.first.to_i
            puts "quantity >>>>>" + quantity.to_s
          end
        end

        if examine_line[-2] == "I" || examine_line[-2].to_i > 0
          if examine_line[-2] == "I"
            quantity = 1
            puts "quantity >>>>>" + quantity.to_s
          else
            quantity = examine_line[-2].to_i
            puts "quantity >>>>>" + quantity.to_s
          end
        end

        if examine_line.last.gsub("$", "").to_f != 0.0 #&& (examine_line.first.is_i? || examine_line[-2].is_i?) && line.contains_letters?
          puts ">>>>>>>>>THIS IS A LINE " + line.to_s
          price = examine_line.last.gsub("$", "")
          puts price
        else
          puts "I SKIPED THIS LINE BECASUE LSAT WASNt float" + line.to_s
        end
      else
        puts "THis is an empty line"
      end
    end

    return @split
  end

  # validates :user, :presence => true

  # def process
  #   self.attachment.file
  #   # do stuff
  #   self.list_items.create!({name: name, amount: amount})
  # end

  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.





end
