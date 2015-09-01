require_relative '../src/mystery_forest'

describe 'mystery forest' do
  it 'should set the scene for the user' do
    introduction = "You are walking around a park, enjoying the sunlight speckling the trees resplendent in vibrant fall colours. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the colour creeps away from your surroundings. As you begin to register the lack of colour, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognise where you are."
    test_output = double("Output")
    test_input = double("Input")

    allow(test_output).to receive(:clear)
    allow(test_output).to receive(:send_output)
    allow(test_input).to receive(:get_input){"quit"}
    expect(test_output).to receive(:send_output).with(introduction)
    
    game = MysteryForest.new(test_input, test_output)
    game.run
  end

end
