require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/invoice'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items       => './test/fixtures/items.csv',
      :merchants   => './test/fixtures/merchants.csv',
      :invoices    => './test/fixtures/invoices.csv'
      })
  end

  def test_class_can_be_instantiated
    assert_instance_of SalesEngine, @se
  end

  def test_sales_engine_has_instances_of_repositories
    assert_instance_of ItemRepository,     @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of InvoiceRepository,  @se.invoices
  end

  def test_merchant_attribute_can_find_by_name
    mr = @se.merchants
    assert_equal 1, mr.find_by_name("Shopin1901").id
  end

  def test_item_attribute_can_find_by_name
    ir = @se.items
    assert_equal 263395617, ir.find_by_name("Glitter scrabble frames").id
  end

  def test_merchant_attribute_can_look_for_items
    merchant = @se.merchants.find_by_id(1)

    assert_equal [], merchant.items
  end

  def test_item_attribute_can_look_for_merchants
    items = @se.items.find_by_id(263395617)
    assert_equal 12334185, items.merchant.id
  end

  def test_class_has_an_invoices_method
    merchant = @se.merchants.find_by_id(1)
    assert_instance_of Invoice,merchant.invoices
  end

  def test_can_find_merchants_from_an_invoice
    invoice = @se.invoices.find_by_id(1)
    assert_instance_of Merchant, invoice.merchant
  end
end
