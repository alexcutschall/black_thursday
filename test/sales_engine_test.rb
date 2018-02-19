require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/merchant'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items       => './test/fixtures/items.csv',
      :merchants   => './test/fixtures/merchants.csv',
      })
  end

  def test_class_can_be_instantiated
    assert_instance_of SalesEngine, @se
    binding.pry
  end

  def test_class_can_call_from_csv_function
    skip
=======
  end

  def test_sales_engine_has_instances_of_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_merchant_attribute_can_find_by_name
    skip
    mr = @se.merchants
    assert_equal "name", mr.find_by_name("name")
  end

  def test_item_attribute_can_find_by_name
    skip
    ir = @se.items
    assert_equal "name", ir.find_by_name("name")
  end

  def test_merchant_attribute_can_look_for_items
    skip
    merchant = @se.merchants.find_by_id(1)

    assert_equal [], merchant.items
  end

  def test_item_attribute_can_look_for_merchants
    skip
    items = @se.items.find_by_id(1)
    assert_equal merchant, items.merchant
  end
end
