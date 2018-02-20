class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent = nil)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @parent      = parent
    @current_location = nil
  end

  def merchant
    find_current_location
    if @current_location.parent == nil
       @current_location.merchant.find_by_id(@merchant_id)
    else
      move(@current_location)
    end
  end

  def find_current_location
    if @current_location == nil
      @current_location = self
    else
      @current_location
    end
  end

  def move(current_location)
    @current_location = @current_location.parent
    merchant
  end
end
