require "date"
class Market
  attr_reader :name, :vendors, :date
  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today.strftime("%d/%m/%y")
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    # as a one liner: 
    # @vendors.map do {|vendor| vendor.name}
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.select { |vendor| vendor.check_stock(item) > 0 }
  end

  def sorted_item_list
    @list = @vendors.flat_map do |vendor|
      vendor.inventory.keys.map do |item|
        item.name
      end
    end
    @list.uniq.sort
    #require 'pry';binding.pry
    #An array of the names of all items the Vendors have in stock, sorted alphabetically.
    #This list should not include any duplicate items.
  end

  def total_inventory
    hash = Hash.new { |hash, key| hash[key]= { number: 0, vendors: [] } }
    @vendors.each do |vendor|
      vendor.inventory.each do |item, number|
        hash[item][:number] += number
        hash[item][:vendors] << vendor
      end
    end
    hash
    #inventory = {}
    #@vendors.each do |vendor|
    #vendor.inventory.each do |item, qty|
    #inventory[item]={quantity: get_item_quantity(item), vendors: vendors_that_sell(item)}
    #end
    #end
    #inventory

    #def get_item_quantity(item)
    #total=0
    #vendors_that_sell(item).each do |vendor|
    #total += vendor.check_stock(item)
    #end
    #total
    #end
  end

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, data|
      if data[:vendors].size > 1 && data[:number] > 50
        overstocked_items << item
      end
    end
    overstocked_items
  end

  def sell(item, quantity)
    if !total_inventory[item].nil? && total_inventory[item][:number] >= quantity
      total_inventory[item][:vendors].each do |vendor|
        until quantity.zero? || vendor.inventory[item].zero?
          vendor.inventory[item] -= 1
          quantity -= 1
        end
      end
      true
    else
      false
    end
  end
end