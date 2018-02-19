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
  
  def test_item_find_by_name
    skip
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    result = item_repository.find_by_name("cache cache à la plage")

    assert_instance_of Item, result
    assert_equal "Cache cache à la plage", result.name
  end

  def test_item_find_all_with_description
    item_repository = ItemRepository.new('./test/fixtures/items.csv')

    results = item_repository.find_all_with_description("disney")

    assert_instance_of Array, results
    assert results.all? do |result|
      result.description.include?("Disney")
    end
  end
end
