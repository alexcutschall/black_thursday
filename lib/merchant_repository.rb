require 'CSV'
require_relative 'merchant'

class MerchantRepository
  attr_reader :parent
  def initialize(filepath, parent = nil)
    @merchants = []
    load_merchants(filepath)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    CSV.foreach(filepath, headers: true,
                header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
       merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
         merchant.name.downcase.include? name.downcase
      end
  end
end
