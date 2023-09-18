require "date"
class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
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

end