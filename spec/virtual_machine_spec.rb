require 'virtual_machine'
require 'processor'
require 'tempfile'
require 'console'

describe VirtualMachine do

  let (:console) { Console.new(StringIO.new, StringIO.new) }

  it 'has empty memory when initiliased' do
    vm = VirtualMachine.new(console)
    expect(vm.memory_used).to eq 0
  end

  it 'loads a program file into 16-bit memory' do
    test = Tempfile.new('test')
    test.write("aaaa")
    test.rewind
    vm = VirtualMachine.new(console)
    vm.readfile(test)
    expect(vm.memory_used).to eq 2
  end

  it 'runs a file' do
    test = Tempfile.new('test')
    codes = [0]
    test.write(codes.pack('S'))
    test.rewind
    vm = VirtualMachine.new(console)
    expect{vm.run(test)}.to raise_error SystemExit
  end

end
