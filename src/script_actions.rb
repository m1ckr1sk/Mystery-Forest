class ScriptActions
  def initialize
    @actions = {
            greet: ["'Hello,' the man smiles at you.", [:ask_purpose]],
            purpose: ["'I am here to guide you.'", [:bye]],
            bye: ["'I will see you later.'", []]
          }
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