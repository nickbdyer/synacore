class Loader

  attr_reader :instructions

  def initialize
    @instructions = []
  end

  def readfile filepath
    File.open(filepath, 'rb') do |file|
      until file.eof? do
        buffer = file.read(2)
        instructions << buffer.unpack('S')[0]
      end
    end
    instructions
  end

end
