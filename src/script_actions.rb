require 'json'

class ScriptActions
  def initialize(actions)
    @actions = actions
    STDOUT.puts @actions.to_json
  end
  
  def first_action
    :greet
  end
  
  def current_responses current_action, responses
    @actions[current_action][1].collect { |response_index| responses.response_at_index response_index }
  end
  
  def action_output current_action
    @actions[current_action].first
  end
end