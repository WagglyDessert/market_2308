class Vendor
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if @inventory[:item] == nil
      return 0
    else
      @inventory[:item]
    end
  end

  def stock(item, number)
    @inventory[:item] ||= 0
    @inventory[:item] += number
  end
end