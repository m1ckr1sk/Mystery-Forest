# Mark Harder
# 2013.03.09
# scripts for all the people you interact with

class Script
  def run input, output, name
    case name
    when "Malich"
      actions = {
        greet: ["'Hello,' the man smiles at you.", [:ask_purpose]],
        purpose: ["'I am here to guide you.'", [:bye]],
        bye: ["'I will see you later.'", []]
      }
      responses = {
        ask_purpose: ["'What are you doing here?'", :purpose],
        bye: ["'Good bye.'", :bye]
      }
      current = :greet
      current_responses = actions[current][1].collect { |a| responses[a] }
      num_responses = current_responses.length

      begin
        response = -1
        while response < 0 || response >= num_responses do
          
          output.send_output actions[current].first
          output.send_output "Your response:"

          0.upto(num_responses - 1) do |i|
            output.send_output "#{i + 1}. #{current_responses[i][0]}"
          end
          output.send_output ": "
          response = input.get_input.to_i - 1
          output.clear
        end

        current = current_responses[response][1]
        current_responses = actions[current][1].collect { |a| responses[a] }
        num_responses = current_responses.length
      end until num_responses == 0
    end
  end
end

