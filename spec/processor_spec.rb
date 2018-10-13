require 'processor'
require 'console'

describe Processor do

  let (:output) { StringIO.new }
  let (:console) { Console.new(StringIO.new, output) }

  it 'terminates the process if it reads a 0 instruction' do
    processor = Processor.new([0], console)
    expect{processor.start}.to raise_error SystemExit
  end

  it 'does nothing if it reads a 21 instruction' do
    processor = Processor.new([21, 0], console)
    expect{processor.start}.to raise_error SystemExit
  end

  it 'outputs the following ascii character if it reads a 19 instruction' do
    processor = Processor.new([19, 65, 0], console)
    expect{processor.start}.to raise_error SystemExit
    expect(output.string).to eq "A"
  end

end
