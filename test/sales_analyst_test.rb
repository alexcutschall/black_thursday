require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items       => './test/fixtures/items.csv',
      :merchants   => './test/fixtures/merchants.csv',
      })

    @sa = SalesAnalyst.new(@se)
  end

  def test_class_can_be_instantiated
    assert_instance_of SalesAnalyst, @sa
  end

  def test_class_has_access_to_merchants_and_items
    assert_instance_of MerchantRepository, @sa.merchants
    assert_instance_of ItemRepository, @sa.items
  end

  def test_can_find_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end


end
