require_relative '../src/command'
require_relative '../src/command_store'
require_relative '../src/player'

describe 'command' do
  it 'should have a list of tokens' do
    command = Command.new()
    expect(command.to_s).to eq("")
  end

  it 'should take a list of tokens' do
    command = Command.new(['token1'])
    expect(command.to_s).to eq("token1")
  end

  it 'should return a token at an index' do
    command = Command.new(['token1','token2'])
    expect(command.at(1)).to eq("token2")
    expect(command.at(0)).to eq("token1")
  end
  
  it 'should return the next command' do
      command_store = CommandStore.new
      environment = Environment.new
      player = Player.new(environment)
      command = Command.new(['token1','token2'])
      puts command.next(command_store, player)
    end
end