require 'bigdecimal'
require 'time'

class Item
  attr_reader :name,
              :description,
              :id,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent,
              :merchants

  def initialize(data, parent = nil)
    @id           = data[:id].to_i
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = BigDecimal(data[:unit_price]) / 100
    @merchant_id  = data[:merchant_id].to_i
    @created_at   = Time.parse(data[:created_at].to_s)
    @updated_at   = Time.parse(data[:updated_at].to_s)
    @parent = parent
    @current_location = nil
    @merchants = nil
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
      @merchants = @current_location.merchants.find_by_id(@merchant_id)
    else
      move
    end
  end
end
