class VirtualMachine

  attr_reader :memory, :console

  def initialize memory, console
    @memory = memory
    @console = console
  end

  def start
    run 0
  end

  def run index
    case memory[index]
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
    console.print memory[index + 1].chr
    run index + 2
  end

  def noop index
    run index + 1
  end

end
