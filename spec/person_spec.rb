require_relative '../src/person'

describe 'person' do
  it 'should have a name' do
    #arrange
    persons_name = 'derek'
    person = Person.new(persons_name, '',nil)

    #act
    actual_persons_name = person.name

    #assert
    expect(actual_persons_name).to eq(persons_name)
  end

  it 'should have a description' do
    #arrange
    persons_description = 'description'
    person = Person.new('', persons_description,nil)

    #act
    actual_persons_description = person.description

    #assert
    expect(actual_persons_description).to eq(persons_description)
  end

  it 'should have a run a script when talk is invoked' do
    #arrange
    script = double("script")
    persons_description = 'description'
    person = Person.new('', '',script)
    
    #assert
    expect(script).to receive(:run)
    
    #act
    person.talk nil, nil
  end
end