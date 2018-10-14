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
    return if @index > memory.length
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
    end
    run
  end

  private

  def halt
    exit
  end

  def set
    register_no = memory[@index + 1] - 32768
    register[register_no] = get_value(memory[@index + 2])
    @index += 3
  end

  def push
    item = get_value(memory[@index + 1])
    stack.push item
    @index += 2
  end

  def pop
    item = stack.pop
    register_no = memory[@index + 1] - 32768
    register[register_no] = item
    @index += 2
  end

  def jump
    jump_location = get_value(memory[@index + 1])
    @index = jump_location
  end

  def rmem
    register_no = memory[@index + 1] - 32768
    read_location = memory[@index + 2]
    register[register_no] = memory[read_location]
    @index += 3
  end

  def wmem
    write_location = memory[@index + 1]
    value = get_value(memory[@index + 2])
    memory[write_location] = value
    @index +=3
  end

  def print_ascii
    character = get_value(memory[@index + 1]).chr
    console.print character
    @index += 2
  end

  def noop
    @index += 1
  end

  def get_value number
    return get_register number if (32768..32775).include? number
    number
  end

  def get_register number
    register[number - 32768]
  end

end
