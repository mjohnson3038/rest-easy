require 'rTesseract'

# require 'carrierwave/orm/activerecord'

class Receipt < ActiveRecord::Base
  belongs_to :user
  has_many :list_items

  # validates :user, :presence => true

  # def process
  #   self.attachment.file
  #   # do stuff
  #   self.list_items.create!({name: name, amount: amount})
  # end

  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.

  def process
    # Turns image into an array of text strings which.
    file = self.attachment.file.file
    image = RTesseract.new(file)
    @split = image.to_s.split("\n")

    @split.each do |line|
      # Go through each line and in each line, check that the last thing is a float, the item directly before the float OR the first item is a single integer, and then it also contains some kind of aphabetical text" If all this is true, then it is a true line item in the receipt, all other receipt lines will be ignored.
      examine_line = line.split(" ")
      if examine_line.last.to_f == 0.0 && (examine_line.first.is_i? || examine_line[-2].is_i?) && line.contains_letters?
        puts "THIS IS A LINE" + line.to_s
      end
    end
  end

  private

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




end
