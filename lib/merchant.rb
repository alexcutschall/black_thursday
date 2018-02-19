class Merchant
  attr_reader :id,
              :name,
              :parent,
              :current_location

   def initialize(data, parent = nil)
    @id   = data[:id].to_i
    @name = data[:name]
    @parent = parent
    @current_location = nil
  end

  def items
    find_current_location
    if @current_location.parent == nil
      @current_location.items.find_all_by_merchant_id(@id)
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
    items
  end
end
