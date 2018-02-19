require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/merchant'

class SalesEngineTest < Minitest::Test
  def setup
    @se = se = SalesEngine.from_csv({
      :items       => './test/fixtures/items.csv',
      :merchants   => './test/fixtures/merchants.csv',
      })
  end

  def test_class_can_be_instantiated
    assert_instance_of SalesEngine, @se
  end

  def test_class_can_call_from_csv_function

    binding.pry
  end
end
