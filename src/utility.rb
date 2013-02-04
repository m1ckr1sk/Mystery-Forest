# Mark Harder
# 2013.01.31
# A class of utility functions

module Utility
  def clear_screen
    print "\e[2J\e[24H"
  end

  def format_output_wrap str
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
