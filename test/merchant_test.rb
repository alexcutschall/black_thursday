require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

class MerchantTest < Minitest::Test

  def test_it_can_be_instantiated
    merchant = Merchant.new({:id =>"5", :name => "Turing School"})
    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes_id_and_name
    merchant = Merchant.new({:id =>"5", :name => "Turing School"})

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
  end

  def test_it_can_have_different_attributes
    merchant = Merchant.new({:id => 6, :name => "Codecademy"})

    assert_equal 6, merchant.id
    assert_equal "Codecademy", merchant.name
  end

  def test_class_can_find_current_location
    merchant = Merchant.new({:id => 6, :name => "Codecademy"})

    merchant.find_current_location

    assert_instance_of Merchant, merchant.current_location
  end

  def test_class_can_move_locations
    merchant = Merchant.new({:id => 6, :name => "Codecademy"})

    merchant.find_current_location
    assert_instance_of Merchant, merchant.current_location

  end
end
