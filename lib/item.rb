class Item
  attr_reader :name,
              :description,
              :id,
              :price

  def initialize(data)
    @id           = data[:id].to_i
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = data[:unit_price]
    @merchant_id  = data[:merchant_id]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
  end

  def unit_price_to_dollars
    "$" + @unit_price.to_f.to_s
  end
end
