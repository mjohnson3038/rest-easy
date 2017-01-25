module ApplicationHelper
  def money_format(price)
    "$%.2f" % price
  end
end
