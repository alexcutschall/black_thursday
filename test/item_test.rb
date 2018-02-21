require 'bigdecimal'
require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({:name  => "Pencil",
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
    assert_equal 0.1099e2, @item.unit_price
  end

  def test_class_has_a_price_to_dollars
    assert_equal 0.1099e2, @item.unit_price

    result = @item.unit_price_to_dollars

    assert "$10.99", result
  end

  def test_can_change_a_different_big_decimal
    item = Item.new({:name  => "Pencil",
                     :description   => "You can use it to write things",
                     :unit_price    => BigDecimal.new(100.31, 5),
                     :created_at    => Time.now,
                     :updated_at    => Time.now,
                     })

    assert_equal 0.10031e3, item.unit_price

    result = item.unit_price_to_dollars

    assert_equal "$100.31", result
  end
end
