require 'bigdecimal'

class Item
  attr_reader :name,
              :description,
              :id,
              :unit_price,
              :created_id,
              :updated_at,
              :merchant_id,
              :parent

  def initialize(data, parent = nil)
    @id           = data[:id].to_i
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = BigDecimal.new(data[:unit_price])
    @merchant_id  = data[:merchant_id].to_i
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @parent = parent
    @current_location = nil
  end

  def unit_price_to_dollars
    @unit_price = "$" + @unit_price.to_f.to_s
  end

  def find_current_location
    if @current_location == nil
       @current_location = self
     else
       @current_location
     end
  end

  def move
    @current_location = @current_location.parent
    merchant
  end

  def merchant
    find_current_location
    if @current_location.parent == nil
      @current_location.merchant.find_by_id(@merchant_id)
    else
      move
    end
  end
end
