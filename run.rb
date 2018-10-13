#! /usr/local/bin/ruby

require './lib/virtual_machine.rb'
require './lib/processor.rb'
require './lib/console.rb'

VirtualMachine.new.run('./challenge.bin')
