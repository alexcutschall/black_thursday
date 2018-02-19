require 'CSV'
require_relative '../lib/merchant'

class MerchantRepository

  def initialize(filepath)
    @merchants = []
    load_merchants(filepath)
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
       return merchant if merchant.name.downcase == merchant.name.downcase
    end
  end

    def find_all_by_name(name)
      @merchants.find do |merchant|
         return merchant if merchant.name.downcase.include? merchant.name.downcase
      end
    end


end
