class OutputLogger
  def initialize
    @logged_output = []
  end

  def send_output(output)
    STDOUT.puts("TEST HAS RECIEVED:#{output}")
    @logged_output << output
  end

  def clear
    send_output('clear')
  end

  def output_logged
    return @logged_output
  end
end