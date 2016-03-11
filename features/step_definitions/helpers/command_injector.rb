class CommandInjector
  def initialize(commands)
    @commands = commands
    @current_command= 0
  end

  def get_input
    command = 'quit'
    if @current_command < @commands.length
      command = @commands[@current_command]
      @current_command = @current_command + 1
    end
    STDOUT.puts "TEST HAS BEEN ASKED FOR INPUT AND RESPONDED WITH:#{command}"
    return command

  end
end