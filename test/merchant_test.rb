require 'test_helper'
require '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_can_be_instantiated
    merchant = Merchant.new({:id =>5, :name => "Turing School"})
    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes_id_and_name
    merchant = Merchant.new({:id =>5, :name => "Turing School"})

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
  end

  def test_it_can_have_different_attributes
    merchant = Merchant.new({:id => 6, :name => "Codecademy"})

    assert_equal 6, merchant.id
    assert_equal "Codecademy", merchant.name
  end
end
