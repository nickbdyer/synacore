require 'processor'

describe Processor do

  it 'terminates the process if it reads a 0 instruction' do
    processor = Processor.new
    expect{processor.run([0])}.to raise_error SystemExit
  end

end
