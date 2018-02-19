require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemRepositoryTest < Minitest::Test

  def test_it_can_be_instantiated
    item_repository = ItemRepository.new('./test/fixtures/items.csv')
    assert_instance_of ItemRepository, item_repository
  end

  def test_item_repository_has_items
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    assert_equal 5, item_repository.all.count
  end

  def test_item_repository_can_find_by_id
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    result = item_repository.find_item_by_id(263396013)

    assert_instance_of Item, result
    assert_equal "Free standing Woden letters", result.name
    assert_equal 263396013, result.id
  end

  def test_item_repository_can_find_all_by_merchant_id
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    result = item_repository.find_all_by_merchant_id(12334185)
    assert_instance_of Array, result
    assert_instance_of Item, result.first
  end

  def test_can_find_all_by_price_in_range
      item_repository = ItemRepository.new('./test/fixtures/items.csv')

      result = item_repository.find_all_by_price_in_range(0,100)

      assert_equal [], result

      result = item_repository.find_all_by_price_in_range(0, 1500)
      assert_instance_of Item, result.first
  end
end
