require './lib/item'
require './lib/vendor'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  it 'can initialize' do
    expect(@vendor).to be_an_instance_of(Vendor)
  end

  it 'has attributes' do
    expect(@vendor.name).to eq("Rocky Mountain Fresh")
    expect(@vendor.inventory).to eq({})
    expect(@vendor.check_stock(@item1)).to eq(0)
  end

  it 'can stock items' do
    @vendor.stock(@item1, 30)
    expect(@vendor.check_stock(@item1)).to eq(30)
    expect(@vendor.inventory).to eq({@item1 => 30})
  end

  it 'can add stock to existing stock' do
    @vendor.stock(@item1, 30)
    expect(@vendor.check_stock(@item1)).to eq(30)
    @vendor.stock(@item1, 25)
    expect(@vendor.check_stock(@item1)).to eq(55)
  end

end
