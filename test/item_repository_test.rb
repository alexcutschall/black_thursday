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
    binding.pry
    assert_equal 4, item_repository.all.count
  end
end
