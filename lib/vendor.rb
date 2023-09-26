class Vendor
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = {}
    # @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item] || 0
    # @inventory[item] if using hash.new in initialize
    # can also use @inventory.fetch(item, 0)
  end

  def stock(item, quantity)
    @inventory[item] ||= 0
    @inventory[item] += quantity
    # @inventory[item] += quantity just this is using hash.new in initialize
    # can also do:
    # if @inventory[item] != nil
    # @inventory[item] += quantity
    # else
    # @inventory[item] = quantity
  end

  def potential_revenue
    @inventory.sum { |item, quantity| item.price * quantity }
    # inventory is a hash so you define 'k v' pair (item, quantity) to iterate through it
  end
end