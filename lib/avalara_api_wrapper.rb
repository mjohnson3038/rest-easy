require 'httparty'

class AvalaraApiWrapper
  BASE_URL = "https://taxrates.api.avalara.com:443/postal?"
  KEY = ENV["AVALARA_ACCESS_KEY"]
  COUNTRY = "usa"

  def self.sales_tax(zip)
  #   url = BASE_URL + "country=#{COUNTRY}" + "&postal=#{zip}" + "&apikey=#{KEY}"

    data = HTTParty.get(url)
    tax = []

    wrapper = Tax.new data["totalRate"]
    tax << wrapper

    return tax

  end
end
