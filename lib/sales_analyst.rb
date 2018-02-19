class SalesAnalyst
  attr_reader :merchants,
              :items,
              :item_count

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants    = sales_engine.merchant
    @items        = sales_engine.items
    @item_count   = nil
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
    @deviation = Math.sqrt(times.sum / (times.count - 1)).round(2)
  end

  def average_item_price_for_merchant(id)
    merchant = @merchants.find_by_id(id)
    prices = merchant.items.map do |item|
      item.unit_price
    end
    average(prices).round(2)
  end
end
