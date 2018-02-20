require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require 'CSV'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_can_be_instantiated
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')
    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_it_can_find_all_of_the_invoices
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')
    assert_instance_of Array, invoice_repository.all
    assert_instance_of Invoice, invoice_repository.all.first
  end

  def test_it_can_find_by_id
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    result     = invoice_repository.find_by_id(1)
    result_nil = invoice_repository.find_by_id(78)

    assert_instance_of Invoice, result
    assert_equal 12335938,      result.merchant_id
    assert_nil                  result_nil
  end

  def test_it_can_find_all_by_id
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    result = invoice_repository.find_all_by_customer_id(1)

    assert_equal [],            invoice_repository.find_all_by_customer_id(123415155)
    assert_instance_of Invoice, result.first
    assert_equal 1,             result.first.id
  end

end
