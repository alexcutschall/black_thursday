require 'bigdecimal'
require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = item = Item.new({:name  => "Pencil",
                     :description   => "You can use it to write things",
                     :unit_price    => BigDecimal.new(10.99,4),
                     :created_at    => Time.now,
                     :updated_at    => Time.now,
                     })
  end

  def test_class_can_be_instantiated
    assert_instance_of Item, @item
  end

  def test_class_has_attributes
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
  end

  def test_class_has_a_price_to_dollars
    assert 10.99, @item.price

    result = @item.unit_price_to_dollars

    assert "$10.99", @item.price
  end

end
