class ScriptResponses
  def initialize(responses)
    @responses = responses
  end
  
  def response_at_index index
    @responses[index]
  end
end