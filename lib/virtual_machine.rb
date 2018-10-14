require 'stack'

class VirtualMachine

  attr_reader :memory, :console, :stack, :register

  def initialize memory, console
    @memory = memory
    @console = console
    @stack = Stack.new
    @register = []
    @index = 0
  end

  def start
    run
  end

  def run
    halt if @index > memory.length
    case memory[@index]
    when 0
      halt
    when 1
      set
    when 2
      push
    when 3
      pop
    when 6
      jump
    when 15
      rmem
    when 16
      wmem
    when 19
      print_ascii
    when 21
      noop
    else
      @index += 1
      run
    end
  end

  def halt
    exit
  end

  def set
    register_no = memory[@index + 1] - 32768
    register[register_no] = memory[@index + 2]
    @index += 3
    run
  end

  def push
    item = memory[@index + 1]
    stack.push item
    @index += 2
    run
  end

  def pop
    item = stack.pop
    write_location = memory[@index + 1]
    memory[write_location] = item
    @index += 2
    run
  end

  def jump
    jump_location = memory[@index + 1]
    @index = jump_location
    run
  end

  def rmem
    write_location = memory[@index + 1]
    read_location = memory[@index + 2]
    memory[write_location] = memory[read_location]
    @index += 3
    run
  end

  def wmem
    write_location = memory[@index + 1]
    value = memory[@index + 2]
    memory[write_location] = value
    @index +=3
    run
  end

  def print_ascii
    console.print memory[@index + 1].chr
    @index += 2
    run
  end

  def noop
    @index += 1
    run
  end

end
