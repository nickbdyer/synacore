#! /usr/local/bin/ruby

$LOAD_PATH << './lib'

require './lib/loader.rb'
require './lib/virtual_machine.rb'
require './lib/console.rb'

VirtualMachine.new(Loader.new.readfile('./challenge.bin'), Console.new).start
