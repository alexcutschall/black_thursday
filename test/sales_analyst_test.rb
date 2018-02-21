require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => './test/fixtures/items.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices  => './test/fixtures/invoices.csv'
      })

    @sa = SalesAnalyst.new(@se)


    @se_test = SalesEngine.from_csv({
      :items     => './test/fixtures/items_test.csv',
      :merchants => './test/fixtures/merchants_test.csv',
      :invoices  => './test/fixtures/invoices.csv'
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
end
