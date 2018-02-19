require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_reader :items,
              :merchants,
              :parent

  def initialize(data, parent = nil)
    @items = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @parent = parent
  end

  def self.from_csv(data)
    new(data)
  end
end
