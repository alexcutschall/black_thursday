require_relative '../lib/invoice'
require 'CSV'

class InvoiceRepository

  attr_reader :parent

  def initialize(filepath, parent = nil)
    @invoices = []
    load_invoices(filepath)
    @parent   = parent
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def load_invoices(filepath)
    CSV.foreach(filepath, headers: true,
                header_converters: :symbol) do |data|
    @invoices << Invoice.new(data, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |invoice|
         invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all do |invoice|
         invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
         invoice.status == status
    end
  end

  def find_day_of_date
    @invoices.map do |invoice|
      invoice.created_at.strftime('%A')
    end
  end
end
