require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def class_can_be_instantiated
    transaction_repository = TransactionRepository.new
    assert_instance_of TransactionRepository, transaction_repository
  end
end
