require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/customer_repository'

require 'bigdecimal'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items        => './test/fixtures/items.csv',
      :merchants    => './test/fixtures/merchants.csv',
      :invoices     => './test/fixtures/invoices.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers    => './test/fixtures/customers.csv',
      })

    @sa = SalesAnalyst.new(@se)


    @se_test = SalesEngine.from_csv({
      :items        => './test/fixtures/items_test.csv',
      :merchants    => './test/fixtures/merchants_test.csv',
      :invoices     => './test/fixtures/invoices_test.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers    => './test/fixtures/customers.csv',
      })

    @sa_test = SalesAnalyst.new(@se_test)
  end

  def test_class_can_be_instantiated
    assert_instance_of SalesAnalyst, @sa
  end

  def test_class_has_access_to_merchants_and_items
    assert_instance_of MerchantRepository, @sa.merchants
    assert_instance_of ItemRepository, @sa.items
  end

  def test_can_output_list_of_merchant_items
    assert_equal [0,0,3,0,0], @sa.item_count
  end

  def test_can_output_a_different_list_of_merchant_items
    assert_equal [2,0,0,1,1], @sa_test.item_count
  end

  def test_can_find_average_items_per_merchant
    assert_equal 0.6, @sa.average_items_per_merchant
  end

  def test_can_output_a_different_average_items_per_merchant
    assert_equal 0.8, @sa_test.average_items_per_merchant
  end

  def test_average_can_average_numbers
    assert_equal 1.0, @sa.average([1,1,1,1,1])
  end

  def test_can_find_standard_deviation
    assert_equal 1.34, @sa.average_items_per_merchant_standard_deviation
  end

  def test_can_find_different_deviation
    assert_equal 0.84, @sa_test.average_items_per_merchant_standard_deviation
  end

  def test_can_find_top_seller
    assert_equal "MiniatureBikez", @sa.merchants_with_high_item_count.first.name
  end

  def test_can_find_different_top_seller
    assert_equal 12334186, @sa_test.merchants_with_high_item_count.first.id
    assert_equal 12334186, @sa_test.merchants_with_high_item_count.last.id
  end

  def test_the_average_price_of_a_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334185)
    assert_equal 0.1117e2, @sa.average_item_price_for_merchant(12334185)
  end

  def test_can_find_number_of_invoices_for_each_merchant
    assert_equal [3, 0, 0, 0, 0], @sa.invoice_count

    assert_equal 0.6, @sa.average_invoices_per_merchant
  end

  def test_can_find_standard_deviation_for_invoices_per_merchant
    assert_equal 1.34, @sa.average_invoices_per_merchant_standard_deviation
  end

#add fixtures to test these rather than the sa
  def test_can_find_top_merchants_by_invoice_count
    assert_equal [], @sa_test.top_merchants_by_invoice_count
  end

  def test_can_find_bottom_merchants_by_invoice_count
    assert_nil @sa.bottom_merchants_by_invoice_count.first
  end

  def test_can_find_how_many_invoices_there_are_per_day
    assert_instance_of Hash, @sa.finding_number_of_invoices_per_day
  end

  def test_can_find_number_of_invoices_for_days_of_week
    assert_equal 5, @sa.invoice_dates.length
    assert_equal 2, @sa.finding_number_of_invoices_per_day["Saturday"]
  end

  def test_can_find_standard_deviation_for_invoices_on_days
    assert_equal 0.9, @sa.invoice_deviation
  end

  def test_can_find_top_days_by_invoice_count
    assert_equal ["Saturday", "Friday", "Wednesday", "Monday"], @sa.top_days_by_invoice_count
  end

  def test_can_find_percentage_of_certain_status
    assert_equal 60.00, @sa.status(:pending)
    assert_equal 40.00, @sa.status(:shipped)
  end

end
