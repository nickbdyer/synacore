require 'virtual_machine'
require 'processor'
require 'tempfile'

describe VirtualMachine do

  it 'has empty memory when initiliased' do
    processor = Processor.new
    vm = VirtualMachine.new(processor)
    expect(vm.memory_used).to eq 0
  end

  it 'loads a program file into 16-bit memory' do
    test = Tempfile.new('test')
    test.write("aaaa")
    test.rewind
    processor = Processor.new
    vm = VirtualMachine.new(processor)
    vm.readfile(test)
    expect(vm.memory_used).to eq 2
  end

  it 'runs a file' do
    test = Tempfile.new('test')
    test.write("00")
    test.rewind
    processor = Processor.new
    vm = VirtualMachine.new(processor)
    expect(vm.run(test)).to eq 0
  end

end
