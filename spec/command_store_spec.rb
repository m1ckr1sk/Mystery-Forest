require_relative '../src/command_store'
require_relative '../src/player'

describe 'command store' do
  it 'should store a command' do
    command_store = CommandStore.new()
    command_store.store("I am a command")
    expect(command_store.has_next?()).to be_truthy
  end

  it 'should store a command' do
    command_store = CommandStore.new()
    command_store.store("I am a command")
    expect(command_store.has_next?()).to be_truthy
  end

  it 'should return all tokens from a command' do
    command_store = CommandStore.new()
    player = Player.new
    command_store.store("move")
    expect(command_store.next_token(player).to_s).to eq('move')

  end

  it 'should return non tokens from a command' do
    command_store = CommandStore.new()
    player = Player.new
    command_store.store("up chicken")
    expect(command_store.next_token(player).to_s).to eq('up chicken')
  end

  it 'should not return synonyms from a command' do
    command_store = CommandStore.new()
    player = Player.new
    command_store.store("pick up chicken")
    expect(command_store.next_token(player).to_s).to eq('take')
    puts command_store.next_token(player).to_s
  end

  it 'should return all tokens from a command multiple' do
    command_store = CommandStore.new()
    player = Player.new
    command_store.store("move north")
    expect(command_store.next_token(player).to_s).to eq('move')
    expect(command_store.next_token(player).to_s).to eq('north')

  end
end