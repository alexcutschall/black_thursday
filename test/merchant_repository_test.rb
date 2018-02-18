require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_can_be_instantiated
    merchant_repository = MerchantRepository.new('./data/merchants.csv')

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_a_merchant_repository_has_merchants
    merchant_repository = MerchantRepository.new('./test/fixtures/merchants.csv')

    assert_equal 4, merchant_repository.all.count
  end
end
