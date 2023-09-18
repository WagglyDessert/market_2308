class Item
  attr_reader :name, :price
  def initialize (item_details)
    @name = item_details[:name]
    @price = item_details[:price]
  end
end