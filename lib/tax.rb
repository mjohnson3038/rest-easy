class Tax

  def initialize(zip, options = {})
    raise ArgumentError if zip == nil || label == ""
    @zip = zip
    @tax = options[:tax]
  end
end
