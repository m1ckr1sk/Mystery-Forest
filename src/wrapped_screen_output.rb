class WrappedScreenOutput
  def send_output(output)
    puts format_output_wrap(output)
  end
  
  def clear
    system "clear" or system "cls"
  end
  
  private
  
  def format_output_wrap(str)
      words = str.split(/\s+/)
      out = [""]
  
      until words.empty? do
        if out[-1].length + words[0].length + 1 >= 80 then
          out.push("")
        end
        out[-1] << words.shift << " "
      end
      
      out.join("\n")
    end
end