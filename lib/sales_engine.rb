require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :customers,
              :parent

  def initialize(data, parent = nil)
    @items        = ItemRepository.new(data[:items], self)
    @merchants    = MerchantRepository.new(data[:merchants], self)
    @invoices     = InvoiceRepository.new(data[:invoices], self)
    @transactions = TransactionRepository.new(data[:transactions], self)
    @customers    = CustomerRepository.new(data[:customers], self)
    @parent       = parent
  end

  def self.from_csv(data)
  new(data)
  end
end
