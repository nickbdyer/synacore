class VirtualMachine

  attr_reader :memory, :processor

  def initialize processor
    @memory = []
    @processor = processor
  end

  def run filepath
    readfile filepath
    processor.run memory
  end

  def readfile filepath
    File.open(filepath, 'rb') do |file|
      until file.eof? do
        buffer = file.read(2)
        memory << buffer.unpack('S')
      end
    end
  end

  def memory_used
    memory.length
  end

end
