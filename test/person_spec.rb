require_relative '../src/person'

describe 'person' do
  it 'should have a name' do
    #arrange
    persons_name = 'derek'
    person = Person.new(persons_name, '')
    
    #act
    actual_persons_name = person.name
    
    #assert
    expect(actual_persons_name).to eq(persons_name)
  end
end