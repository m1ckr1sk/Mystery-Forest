require_relative '../src/item'

describe 'item' do
  it 'should have a name' do
    #arrange
    item_spanner = Item.new('spanner','','')

    #act
    item_name = item_spanner.name()

    #assert
    expect(item_name).to eq('spanner')
  end
end