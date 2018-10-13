require_relative './console'

class VirtualMachine

  attr_reader :memory, :console

  def initialize(console = Console.new)
    @memory = []
    @console = console
  end

  def run filepath
    readfile filepath
    Processor.new(memory, console).start
  end

  def readfile filepath
    File.open(filepath, 'rb') do |file|
      until file.eof? do
        buffer = file.read(2)
        memory << buffer.unpack('S')[0]
      end
    end
  end

  def memory_used
    memory.length
  end

end
