class VirtualMachine

  attr_reader :instructions, :console

  def initialize instructions, console
    @instructions = instructions
    @console = console
  end

  def start
    run 0
  end

  def run index
    case instructions[index]
    when 0
      halt
    when 19
      print_ascii index
    when 21
      noop index
    end
  end

  def halt
    exit
  end

  def print_ascii index
    console.print instructions[index + 1].chr
    run index + 2
  end

  def noop index
    run index + 1
  end


end
