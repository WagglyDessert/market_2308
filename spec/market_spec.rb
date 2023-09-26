require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @market = Market.new("South Pearl Street Farmers Market") 
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
  end

  it 'can initialize' do
    expect(@market).to be_an_instance_of(Market)
  end

  it 'has attributes' do 
    expect(@market.name).to eq("South Pearl Street Farmers Market")
    expect(@market.vendors).to eq([])
  end

  it 'can add vendors' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can find vendors that sell particular items' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
  end

  it 'can define potential revenue' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@vendor1.potential_revenue).to eq(29.75)
    expect(@vendor2.potential_revenue).to eq(345.00)
    expect(@vendor3.potential_revenue).to eq(48.75)
  end

  it 'has a sorted item list' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    #require 'pry';binding.pry
    expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
  end

  it 'has total inventory' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    #expect(@market.total_inventory).to eq({@item1 => {:number=>50, @vendors => [@vendor1, @vendor3]}, @item2 => {:number=>25, @vendors => [@vendor1]}, @item3 => {:number=>7, @vendors => [@vendor2]}, @item2 => {:number=>100, @vendors => [@vendor2]}})
    #not sure what to put for test here
  end

  it 'has overstock' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.overstocked_items).to eq([@item1])
  end

  it "returns the date the market was created" do
    date = Date.today.strftime("%d/%m/%y")
    allow(Date).to receive(:today).and_return(Date.new(2023, 9, 18))
    expect(@market.date).to eq(date)
  end

  it "reduces quantity from stock" do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    #not enough available
    expect(@market.sell(@item1, 200)).to be false
    #this should work
    expect(@market.sell(@item1, 40)).to be true
    #item should not be sold out
    expect(@vendor1.check_stock(@item1)).to be 0
  end
end