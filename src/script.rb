# Mark Harder
# 2013.03.09
# scripts for all the people you interact with
require_relative 'script_responses'
require_relative 'script_actions'

class Script
  def initialize(actions, responses)
    @actions = actions
    @responses = responses
  end
  
  def run input, output, name
    
    current_action = @actions.first_action
    current_responses = @actions.current_responses current_action, @responses
    num_responses = current_responses.length

    begin
      response = -1
      while response < 0 || response >= num_responses do

        output.send_output(@actions.action_output(current_action))
        output.send_output "Your response:"

        0.upto(num_responses - 1) do |i|
          output.send_output "#{i + 1}. #{current_responses[i][0]}"
        end
        output.send_output ": "
        response = input.get_input.to_i - 1
        output.clear
      end

      current_action = current_responses[response][1]
      current_responses = @actions.current_responses current_action, @responses
      num_responses = current_responses.length
    end until num_responses == 0
  end
end

