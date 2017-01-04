require 'httparty'

class AvalaraApiWrapper
  BASE_URL = "https://taxrates.api.avalara.com:443/postal?"
  KEY = ENV["AVALARA_ACCESS_KEY"]
  COUNTRY = "usa"

  def self.sales_tax(zip)
    url = BASE_URL + "country=#{COUNTRY}" + "&postal=#{zip}" + "&apikey=#{KEY}"

    data = HTTParty.get(url)
    sales_tax = []
    tax_sum = 0
    if data["rates"]
      data["rates"].each do |item|
        wrapper = item["rate"]
        sales_tax << wrapper
        tax_sum += wrapper
      end
    end
    return tax_sum
  end
end
