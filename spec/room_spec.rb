require_relative '../src/room'

describe 'room' do
  it 'should have a description' do
    #arrange
    room = Room.new('description',nil,'')

    #act
    description = room.description

    #assert
    expect(description).to eq('description')

  end

  it 'should contain items' do
    #arrange
    items = ['rock','paper','scissors']
    room = Room.new('description',items,nil)

    #act
    actual_items = room.items

    #assert
    expect(items).to eq(actual_items)

  end

  it 'should contain people' do
    #arrange
    people = ['peter','paul','mary']
    room = Room.new('description',nil,people)

    #act
    actual_people = room.people

    #assert
    expect(people).to eq(actual_people)

  end

  it 'should allow the addition of directions' do
    #arrange
    direction = 'north'
    room = Room.new('description',nil,nil)

    #act
    room.add_direction(direction)

    #assert
    expect(room.directions).to include(direction)

  end

  it 'should allow the addition of multiple directions' do
    #arrange
    direction_north = 'north'
    direction_south = 'south'
    room = Room.new('description',nil,nil)

    #act
    room.add_direction(direction_north)
    room.add_direction(direction_south)

    #assert
    expect(room.directions).to include(direction_north)
    expect(room.directions).to include(direction_south)

  end

  it 'should not list directions not added' do
    #arrange
    direction_north = 'north'
    direction_south = 'south'
    room = Room.new('description',nil,nil)

    #act
    room.add_direction(direction_south)

    #assert
    expect(room.directions).to include(direction_south)
    expect(room.directions).to_not include(direction_north)

  end
end