require 'CSV'
require_relative 'item'

class ItemRepository
  attr_reader :parent
  def initialize(filepath, parent = nil)
    @items = []
    load_items(filepath)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true,
                header_converters: :symbol) do |data|
    @items << Item.new(data, self)
    end
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(search_query)
    @items.find_all do |item|
      item.description.downcase == search_query.downcase
    end
  end

  def find_all_by_merchant_id(id)
    merchants = @items.find_all do |item|
      item.merchant_id == id
    end
    merchants
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.cover?(item.unit_price)
    end
  end

end
