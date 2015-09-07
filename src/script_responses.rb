class ScriptResponses
  def initialize
    @responses = {
            ask_purpose: ["'What are you doing here?'", :purpose],
            bye: ["'Good bye.'", :bye]
          }
  end
  
  def response_at_index index
    @responses[index]
  end
end