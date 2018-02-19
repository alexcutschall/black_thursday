require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(data)
    @items = []
    @item_path = load_items(data[:items])
    @merchants = []
    @merchants_path = load_merchants(data[:merchants])
  end

  def self.from_csv(data)
    new(data)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true,
                header_converters: :symbol) do |data|
    @items << Item.new(data)
    end
  end

  def load_merchants(filepath)
    CSV.foreach(filepath, headers: true,
                header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end
end
