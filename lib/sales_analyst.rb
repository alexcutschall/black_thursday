class SalesAnalyst
  attr_reader :merchants,
              :items

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants    = sales_engine.merchant
    @items        = sales_engine.items
  end

  def item_count
    item_count = @merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    average(item_count)
  end

  def average(items)
    count = items.count
    sum = items.sum
    sum / count.to_f
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    times = item_count.map do |item|
      (item - average) ** 2
    end
    Math.sqrt(times.sum / 3).round(2)
  end
end
