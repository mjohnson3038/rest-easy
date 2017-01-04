class Tax
  attr_reader :label

  def initialize(label)
    raise ArgumentError if label == nil || label == ""
    @label = label
  end

  def self.search(zip)

    return 0.9
    # AvalaraApiWrapper.sales_tax(zip)
  end
end
