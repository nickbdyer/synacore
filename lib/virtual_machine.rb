require 'stack'

class VirtualMachine

  attr_reader :memory, :console, :stack

  def initialize memory, console
    @memory = memory
    @console = console
    @stack = Stack.new
  end

  def start
    run 0
  end

  def run index
    case memory[index]
    when 0
      halt
    when 2
      push index
    when 3
      pop index
    when 6
      jump index
    when 15
      rmem index
    when 16
      wmem index
    when 19
      print_ascii index
    when 21
      noop index
    else
      run index + 1
    end
  end

  def halt
    exit
  end

  def push index
    item = memory[index + 1]
    stack.push item
    run index + 2
  end

  def pop index
    item = stack.pop
    write_location = memory[index + 1]
    memory[write_location] = item
    run index + 2
  end

  def jump index
    jump_location = memory[index + 1]
    run jump_location
  end

  def rmem index
    write_location = memory[index + 1]
    read_location = memory[index + 2]
    memory[write_location] = memory[read_location]
    run index + 3
  end

  def wmem index
    write_location = memory[index + 1]
    value = memory[index + 2]
    memory[write_location] = value
    run index + 3
  end

  def print_ascii index
    console.print memory[index + 1].chr
    run index + 2
  end

  def noop index
    run index + 1
  end

end
