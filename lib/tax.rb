class Tax
  attr_reader :zip

  def initialize(zip)
    raise ArgumentError if zip == nil || zip == ""
    @zip = zip
  end

  def self.search(zip)
    puts "YOU MADE IT INTO THE TAX MODELLL!!!"

    return AvalaraApiWrapper.sales_tax(zip)
    # AvalaraApiWrapper.sales_tax(zip)
  end
end
