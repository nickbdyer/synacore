class Console

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
  end

  def print string
    @output.print string
  end

end
