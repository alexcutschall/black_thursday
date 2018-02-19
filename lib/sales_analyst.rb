class SalesAnalyst
  attr_reader :merchants,
              :items
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants    = sales_engine.merchant
    @items        = sales_engine.items
  end

  def average_items_per_merchant
  end
end
