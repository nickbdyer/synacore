require 'virtual_machine'
require 'console'

describe VirtualMachine do

  let (:output) { StringIO.new }
  let (:console) { Console.new(StringIO.new, output) }

  it 'terminates the process if trying to access area outside of memory' do
    vm = VirtualMachine.new([21], console)
    expect{vm.run}.not_to raise_error
  end

  it '0: terminates the process' do
    vm = VirtualMachine.new([0], console)
    expect{vm.run}.to raise_error SystemExit
  end

  it '1: sets a register' do
    vm = VirtualMachine.new([1, 32768, 123], console)
    vm.run
    expect(vm.register[0]).to eq 123
  end

  it 'reads a value from the register' do
    vm = VirtualMachine.new([1, 32768, 65, 19, 32768], console)
    vm.run
    expect(output.string).to eq "A"
  end

  it '2: puts an item on the stack' do
    vm = VirtualMachine.new([2, 123], console)
    vm.run
    expect(vm.stack.peek).to eq 123
  end

  it '3: pops top of stack and write to register' do
    vm = VirtualMachine.new([2, 123, 3, 32768], console)
    vm.run
    expect(vm.register[0]).to eq 123
  end

  it '6: jumps to new memory location' do
    vm = VirtualMachine.new([6, 4, 19, 65, 19, 66], console)
    vm.run
    expect(output.string).to eq "B"
  end

  it '7a: jumps to new memory location conditionally' do
    vm = VirtualMachine.new([7, 30000, 5, 19, 65, 19, 66], console)
    vm.run
    expect(output.string).to eq "B"
  end

  it '7b: does not jump to new memory location conditionally' do
    vm = VirtualMachine.new([7, 0, 5, 19, 65, 19, 66], console)
    vm.run
    expect(output.string).to eq "AB"
  end

  it '8a: jumps to new memory location conditionally' do
    vm = VirtualMachine.new([8, 0, 5, 19, 65, 19, 66], console)
    vm.run
    expect(output.string).to eq "B"
  end

  it '8b: does not jump to new memory location conditionally' do
    vm = VirtualMachine.new([8, 30000, 5, 19, 65, 19, 66], console)
    vm.run
    expect(output.string).to eq "AB"
  end

  it '15: reads memory at one address and writes to another' do
    vm = VirtualMachine.new([21, 21, 19, 65, 15, 32768, 2], console)
    vm.run
    expect(vm.register[0]).to eq 19
  end

  it '16: writes value into memory postion' do
    vm = VirtualMachine.new([21, 21, 19, 65, 16, 0, 30000], console)
    vm.run
    expect(vm.memory).to eq [30000, 21, 19, 65, 16, 0, 30000]
  end

  it '19: outputs the following ascii character' do
    vm = VirtualMachine.new([19, 65], console)
    vm.run
    expect(output.string).to eq "A"
  end

  it '21: does nothing if it reads a 21 instruction' do
    vm = VirtualMachine.new([21], console)
    expect{vm.run}.not_to raise_error
  end

end
