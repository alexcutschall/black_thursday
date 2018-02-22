class SalesAnalyst
  attr_reader :merchants,
              :items,
              :item_count,
              :invoices,
              :customers

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants    = sales_engine.merchants
    @items        = sales_engine.items
    @invoices     = sales_engine.invoices
    @customers    = sales_engine.customers
  end

  def item_count
    @merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def invoice_count
    @merchants.all.map do |merchant|
      merchant.invoices.count
    end
  end

  def invoice_dates
    @invoices.all.map do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def price_count
    @items.all.map do |item|
      item.unit_price
    end
  end

  def average_items_per_merchant
    average(item_count)
  end

  def average_invoices_per_merchant
    @invoice_average = average(invoice_count)
  end

  def average(items)
    count = items.count
    sum = items.sum
    (sum / count.to_f).round(2)
  end

  def deviation(numbers)
    Math.sqrt(numbers.sum / (numbers.count - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    times = item_count.map do |item|
      (item - average) ** 2
    end
    deviation(times)
  end

  def average_item_price_for_merchant(id)
    merchant = @merchants.find_by_id(id)
    prices = merchant.items.map do |item|
      item.unit_price
    end
    average(prices).round(2)
  end

  def merchants_with_high_item_count
    top_sellers = []
    average_items_per_merchant
    average_items_per_merchant_standard_deviation
    @merchants.all.each do |merchant|
      if merchant.items.count >= (average_items_per_merchant_standard_deviation + average_items_per_merchant)
         top_sellers << merchant
      end
     end
     top_sellers
  end

  def average_average_price_per_merchant
    price_average = []
    @merchants.all.each do |merchant|
      price_average << average_item_price_for_merchant(merchant.id)
    end
    average(price_average)
  end

  def average_price_per_merchant_standard_deviation
    average = average_average_price_per_merchant
    times = price_count.map do |price|
      (price - average) ** 2
    end
    deviation(times)
  end

  def golden_items
    expensive = []
    average_price_per_merchant_standard_deviation
    @items.all.each do |item|
      if item.unit_price >= ((average_price_per_merchant_standard_deviation * 2) + @average_price)
        expensive << item
      end
    end
    expensive
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    times = invoice_count.map do |invoice|
      (invoice - average) ** 2
    end
    @invoice_deviation = deviation(times)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    average_invoices_per_merchant_standard_deviation
    @merchants.all.each do |merchant|
      if merchant.invoices.count >= ((@invoice_deviation * 2) + @invoice_average)
         top_merchants << merchant
      end
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    average_invoices_per_merchant_standard_deviation
    @merchants.all.each do |merchant|
      if merchant.invoices.count <= (@invoice_average - (@invoice_deviation * 2))
         bottom_merchants << merchant
      end
    end
    bottom_merchants
  end

  def finding_number_of_invoices_per_day
    invoices_per_day = Hash.new(0)
    invoice_dates.each do |day|
      invoices_per_day[day] += 1
    end
    invoices_per_day
  end

  def invoice_deviation
    days = finding_number_of_invoices_per_day
    total = days.map do |day, count|
      (count - average_invoices_per_merchant) ** 2
    end
    deviation(total)
  end

  def top_days_by_invoice_count
    days = finding_number_of_invoices_per_day
      days.each do |day, number|
        return day if number > (average_invoices_per_merchant_standard_deviation + invoice_deviation)
      end.keys
  end
end
