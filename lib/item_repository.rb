require 'CSV'

class ItemRepository

  def initialize(filepath)
    @items = []
    load_items(filepath)
  end

  def all
    @items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true,
                header_converters: :symbol) do |data|
    @items << Item.new(data)
    end
  end

  def find_item_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_all_with_description(search_query)
    @items.find_all do |item|
      item.description.downcase == search_query.downcase
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

  def find_all_by_price_in_range(range_low, range_high)
    @items.find_all do |item|
      item.unit_price.between?(range_low, range_high)
    end
  end
end
