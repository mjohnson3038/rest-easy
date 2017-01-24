require 'httparty'

class AvalaraApiWrapper
  BASE_URL = "https://taxrates.api.avalara.com:443/postal?"
  KEY = ENV["AVALARA_ACCESS_KEY"]
  COUNTRY = "usa"

  def self.sales_tax(zip)
    url = BASE_URL + "country=#{COUNTRY}" + "&postal=#{zip}" + "&apikey=#{KEY}"
    puts url

    data = HTTParty.get(url)
    puts "data" + data.to_s
    if data["totalRate"]
      puts "YYYESS"
      tax = data["totalRate"]
      puts data["totalRate"]
    else
      puts "NOOOO"
      puts data["totalRate"]
      tax = 0
    end
    # return tax
    return tax

  end
end
