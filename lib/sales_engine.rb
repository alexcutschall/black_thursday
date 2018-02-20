require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine

  attr_reader :items,
              :merchant,
              :invoices,
              :parent

  def initialize(data, parent = nil)
    @items    = ItemRepository.new(data[:items], self)
    @merchant = MerchantRepository.new(data[:merchants], self)
    @invoices = InvoiceRepository.new(data[:invoices], self)
    @parent   = parent
  end

  def self.from_csv(data)
    new(data)
  end
end
